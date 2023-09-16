part of util;

///Recieves a json string and return a List of todos
List<Todo> todoListFromJson(String jsonString) {
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
        isCompleted: element['isCompleted'] ?? '',
      ),
    );
  }

  return todoList;
}
