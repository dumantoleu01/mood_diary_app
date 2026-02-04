import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CalendarPage extends StatefulWidget {
  final DateTime selectedDate;

  const CalendarPage({super.key, required this.selectedDate});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDate;
  late int _selectedHour;
  late int _selectedMinute;
  late ScrollController _scrollController;
  final int _startYear = 2020;
  final int _endYear = 2030;

  static const List<String> _monthNames = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];

  static const List<String> _weekDays = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _selectedHour = widget.selectedDate.hour;
    _selectedMinute = widget.selectedDate.minute;
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedDate() {
    final monthIndex = (_selectedDate.year - _startYear) * 12 + (_selectedDate.month - 1);
    final estimatedOffset = monthIndex * 280.0;
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        estimatedOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToYear(int year) {
    final monthIndex = (year - _startYear) * 12;
    final estimatedOffset = monthIndex * 280.0;
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        estimatedOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToToday() {
    final now = DateTime.now();
    setState(() {
      _selectedDate = DateTime(now.year, now.month, now.day, _selectedHour, _selectedMinute);
      _selectedHour = now.hour;
      _selectedMinute = now.minute;
    });
    _scrollToSelectedDate();
  }

  void _showYearPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _YearPickerSheet(
        startYear: _startYear,
        endYear: _endYear,
        selectedYear: _selectedDate.year,
        onYearSelected: (year) {
          Navigator.pop(context);
          _scrollToYear(year);
        },
      ),
    );
  }

  void _showTimePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _TimePickerSheet(
        initialHour: _selectedHour,
        initialMinute: _selectedMinute,
        onTimeSelected: (hour, minute) {
          setState(() {
            _selectedHour = hour;
            _selectedMinute = minute;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _confirmSelection() {
    final result = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedHour,
      _selectedMinute,
    );
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildYearSelector(),
            _buildWeekDaysHeader(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: (_endYear - _startYear + 1) * 12,
                itemBuilder: (context, index) {
                  final year = _startYear + (index ~/ 12);
                  final month = (index % 12) + 1;
                  return _buildMonthSection(year, month);
                },
              ),
            ),
            _buildTimeSelector(),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: AppColors.hintTextColor, size: 24),
          ),
          TextButton(
            onPressed: _scrollToToday,
            child: Text(
              'Сегодня',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.activeTab),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearSelector() {
    return GestureDetector(
      onTap: _showYearPicker,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_selectedDate.year}',
              style: AppTextStyles.heading.copyWith(fontSize: 24),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekDaysHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _weekDays
            .map((day) => SizedBox(
                  width: 40,
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.calendarWeekday,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildMonthSection(int year, int month) {
    final firstDayOfMonth = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startWeekday = (firstDayOfMonth.weekday - 1) % 7;

    final showYearLabel = month == 1 || (year == _startYear && month == 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showYearLabel)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 24, bottom: 4),
            child: Text(
              '$year',
              style: AppTextStyles.calendarYear,
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
          child: Text(
            _monthNames[month - 1],
            style: AppTextStyles.calendarMonth,
          ),
        ),
        _buildDaysGrid(year, month, daysInMonth, startWeekday),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDaysGrid(int year, int month, int daysInMonth, int startWeekday) {
    final List<Widget> rows = [];
    int day = 1;

    while (day <= daysInMonth) {
      final List<Widget> rowChildren = [];

      for (int i = 0; i < 7; i++) {
        if ((rows.isEmpty && i < startWeekday) || day > daysInMonth) {
          rowChildren.add(const SizedBox(width: 40, height: 40));
        } else {
          final currentDay = day;
          final isSelected = _selectedDate.year == year &&
              _selectedDate.month == month &&
              _selectedDate.day == currentDay;

          rowChildren.add(_buildDayCell(currentDay, isSelected, year, month));
          day++;
        }
      }

      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: rowChildren,
          ),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _buildDayCell(int day, bool isSelected, int year, int month) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = DateTime(year, month, day, _selectedHour, _selectedMinute);
        });
      },
      child: SizedBox(
        width: 40,
        height: 44,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: isSelected
                  ? const BoxDecoration(
                      color: AppColors.activeTab,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Center(
                child: Text(
                  '$day',
                  style: AppTextStyles.calendarDay.copyWith(
                    color: isSelected ? AppColors.white : AppColors.textColor,
                  ),
                ),
              ),
            ),
            if (isSelected)
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.only(top: 2),
                decoration: const BoxDecoration(
                  color: AppColors.activeTab,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return GestureDetector(
      onTap: _showTimePicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Время',
              style: AppTextStyles.bodyLarge,
            ),
            Row(
              children: [
                Text(
                  '${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')}',
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColors.activeTab),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: AppColors.hintTextColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _confirmSelection,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.activeTab,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Готово',
            style: AppTextStyles.button,
          ),
        ),
      ),
    );
  }
}

class _YearPickerSheet extends StatelessWidget {
  final int startYear;
  final int endYear;
  final int selectedYear;
  final ValueChanged<int> onYearSelected;

  const _YearPickerSheet({
    required this.startYear,
    required this.endYear,
    required this.selectedYear,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            'Выберите год',
            style: AppTextStyles.heading,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: endYear - startYear + 1,
              itemBuilder: (context, index) {
                final year = startYear + index;
                final isSelected = year == selectedYear;
                return ListTile(
                  title: Text(
                    '$year',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: isSelected ? AppColors.activeTab : AppColors.textColor,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onTap: () => onYearSelected(year),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TimePickerSheet extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final void Function(int hour, int minute) onTimeSelected;

  const _TimePickerSheet({
    required this.initialHour,
    required this.initialMinute,
    required this.onTimeSelected,
  });

  @override
  State<_TimePickerSheet> createState() => _TimePickerSheetState();
}

class _TimePickerSheetState extends State<_TimePickerSheet> {
  late int _hour;
  late int _minute;

  @override
  void initState() {
    super.initState();
    _hour = widget.initialHour;
    _minute = widget.initialMinute;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Выберите время',
            style: AppTextStyles.heading,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: _hour),
                    itemExtent: 40,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _hour = index;
                      });
                    },
                    children: List.generate(24, (index) {
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: AppTextStyles.bodyLarge,
                        ),
                      );
                    }),
                  ),
                ),
                Text(
                  ':',
                  style: AppTextStyles.heading.copyWith(fontSize: 24),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: _minute),
                    itemExtent: 40,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _minute = index;
                      });
                    },
                    children: List.generate(60, (index) {
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: AppTextStyles.bodyLarge,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => widget.onTimeSelected(_hour, _minute),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.activeTab,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Готово',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
