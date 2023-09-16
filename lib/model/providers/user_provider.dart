part of model;

class UserProvider extends ChangeNotifier {
  final User _user = User();

  User get user => _user;

  num get totalTodos {
    if (_user.todoList.isEmpty) {
      return 0.0001;
    } else {
      return _user.todoList.length;
    }
  }

  num get completedTodos {
    if (_user.todoList.isEmpty) {
      return 0.0001;
    } else {
      return _user.todoList
          .where((Todo todo) => todo.isCompleted)
          .toList()
          .length;
    }
  }

  void updateUserField(dynamic value, String field) {
    switch (field) {
      case 'todoList':
        _user.todoList = value;
        break;
      default:
        log('ERROR: No se reconoce el campo [$field]');
    }
    notifyListeners();
  }
}
