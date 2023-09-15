part of model;

class DateProvider extends ChangeNotifier {
  final DateTime _actualTime = DateTime.now().toLocal();

  final List<String> formatWeekdays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  String get ddmmyyyy =>
      "${_actualTime.day}/${_actualTime.month}/${_actualTime.year}";

  String get weekday => formatWeekdays[_actualTime.weekday - 1];

  String get wellcomeMessage {
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
