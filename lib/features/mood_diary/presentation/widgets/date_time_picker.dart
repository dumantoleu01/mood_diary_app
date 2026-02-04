import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../pages/calendar_page.dart';

class DateTimePicker extends StatelessWidget {
  final DateTime selectedDateTime;
  final ValueChanged<DateTime> onDateTimeChanged;

  const DateTimePicker({
    super.key,
    required this.selectedDateTime,
    required this.onDateTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCalendarPicker(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text(DateFormatter.formatDateTime(selectedDateTime), style: AppTextStyles.dateTime),
            SvgPicture.asset(
              'assets/icons/calendar.svg',
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(AppColors.hintTextColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCalendarPicker(BuildContext context) async {
    final result = await Navigator.push<DateTime>(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(selectedDate: selectedDateTime),
      ),
    );

    if (result != null) {
      final newDateTime = DateTime(
        result.year,
        result.month,
        result.day,
        selectedDateTime.hour,
        selectedDateTime.minute,
      );
      onDateTimeChanged(newDateTime);
    }
  }
}
