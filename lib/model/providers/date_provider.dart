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

  String ddmmyyyy() =>
      "${_actualTime.day}/${_actualTime.month}/${_actualTime.year}";

  String weekday() => formatWeekdays[_actualTime.weekday - 1];
}
