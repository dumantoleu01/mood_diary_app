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

  void _scrollToToday() {
    final now = DateTime.now();
    setState(() {
      _selectedDate = now;
    });
    _scrollToSelectedDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
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

  Widget _buildWeekDaysHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
        final newDate = DateTime(year, month, day);
        Navigator.pop(context, newDate);
      },
      child: SizedBox(
        width: 40,
        height: 40,
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
}
