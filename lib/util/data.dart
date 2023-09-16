part of util;

class Data {
  static Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.get('userName') ?? 'Anónimo',
      'surname': prefs.get('usersurname') ?? '',
      'totalTodos': prefs.get('totalTodos') ?? 0.0001,
      'completedTodos': prefs.get('completedTodos') ?? 0.0001,
    };
  }

  static void updateUserField(dynamic value, String field) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (field) {
      case 'name':
        prefs.setString('userName', value);
        break;
      case 'surname':
        prefs.setString('surname', value);
        break;
      case 'totalTodos':
        prefs.setInt('totalTodos', value);
        break;
      case 'completedTodos':
        prefs.setInt('completedTodos', value);
        break;
      default:
        log('ERROR: No se reconoce el campo [$field]');
    }
  }
}
