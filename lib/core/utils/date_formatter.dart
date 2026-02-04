class DateFormatter {
  DateFormatter._();

  static String formatDateTime(DateTime dateTime) {
    final day = dateTime.day;
    final month = _getMonthName(dateTime.month);
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day $month $hour:$minute';
  }

  static String formatDate(DateTime dateTime) {
    final day = dateTime.day;
    final month = _getMonthName(dateTime.month);
    return '$day $month';
  }

  static String _getMonthName(int month) {
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    return months[month - 1];
  }

  static String getMonthNameNominative(int month) {
    const months = [
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
    return months[month - 1];
  }

  static List<String> get weekdayNames => ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];
}
