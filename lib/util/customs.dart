part of util;

class CustomColors {
  static const Color primary100 = Color(0xFFFF5722);
  static const Color primary200 = Color(0xFFfff3b0);
  static const Color primary300 = Color(0xFFFf8a50);

  static const Color accent100 = Color(0xFF4CAF50);
  static const Color accentDeep100 = Color(0xFF005100);

  static const Color text100 = Color(0xFF333333);

  static const Color ligth = Color(0xFFFDE0DB);
  static const Color dark = Color(0xFF101C2E);
}

class CustomTextStyles {
  static final _base = GoogleFonts.cabin(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: CustomColors.primary200,
  );

  static final disclaimer = _base.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 12,
  );

  static final small = _base.copyWith(
    color: Colors.black,
    fontWeight: FontWeight.w300,
    fontSize: 16,
  );

  static final medium = _base.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static final large = _base.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
}

class CustomTitleStyles {
  static final _base = GoogleFonts.capriola(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: CustomColors.text100,
  );

  static final small = _base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static final large = _base.copyWith(
    color: CustomColors.primary200,
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );
}

class CustomDate {
  static final DateTime _actualTime = DateTime.now().toLocal();

  static final List<String> formatWeekdays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  static final List<String> formattedMonth = [
    'Ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sep',
    'oct',
    'nov',
    'dic',
  ];

  static String get ddmmyyyy =>
      "${_actualTime.day}/${_actualTime.month}/${_actualTime.year}";

  static String get dayMonthYear =>
      "${_actualTime.day} de ${formattedMonth[_actualTime.month - 1]}, ${_actualTime.year}";

  static String get weekday => formatWeekdays[_actualTime.weekday - 1];

  static String get wellcomeMessage {
    int hour = _actualTime.hour;
    if (hour > 16) {
      return 'Buenas noches';
    } else if (hour > 12) {
      return 'Buenas tardes';
    } else {
      return 'Buenos días';
    }
  }
}
