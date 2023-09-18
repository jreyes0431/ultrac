part of model;

class User {
  List<Todo> todoList;
  int indexEditing;

  User({
    this.todoList = const [],
    this.indexEditing = -1,
  });
}
