part of util;

class Data {
  static Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.get('userName') ?? 'Anónimo',
      'surname': prefs.get('usersurname') ?? '',
      'completedTodos': prefs.get('completedTodos') ?? 0.0001,
      'todosJson': prefs.get('todosJson') ?? '',
    };
  }

  ///Recieves a json string and return a List of todos
  static List<Todo> todoListFromJson(String jsonString) {
    if (jsonString.isEmpty) return [];
    final List data = jsonDecode(jsonString);
    List<Todo> todoList = [];

    for (var element in data) {
      Color color = const Color(0xFFfff3b0);
      if (element['bgColor'] != null) {
        color = Color(element['bgColor']);
      }
      todoList.add(
        Todo(
          title: element['title'] ?? '',
          description: element['description'] ?? '',
          bgColor: color,
          isCompleted: element['isCompleted'] ?? false,
        ),
      );
    }
    return todoList;
  }

  ///Recieves a List of todos and return a json string
  static String jsonFromTodoList(List<Todo> todoList) {
    List<Map<String, dynamic>> jsonList = [];

    for (Todo element in todoList) {
      jsonList.add(
        {
          'title': element.title,
          'description': element.description,
          'bgColor': element.bgColor.value,
          'isCompleted': element.isCompleted,
        },
      );
    }

    return jsonEncode(jsonList);
  }

  static void updateUserField(dynamic value, String field) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (field) {
      case 'todosJson':
        prefs.setString('todosJson', value);
      case 'name':
        prefs.setString('userName', value);
        break;
      case 'surname':
        prefs.setString('surname', value);
        break;
      case 'totalTodos':
        prefs.setDouble('totalTodos', value);
        break;
      case 'completedTodos':
        prefs.setDouble('completedTodos', value);
        break;
      default:
        log('ERROR: No se reconoce el campo [$field]');
    }
  }
}
