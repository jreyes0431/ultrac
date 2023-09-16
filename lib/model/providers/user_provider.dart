part of model;

class UserProvider extends ChangeNotifier {
  final User _user = User();

  User get user => _user;

  void updateUser(User user) {
    _user.name = user.name;
    _user.surname = user.surname;
    _user.completedTodos = user.completedTodos;
    _user.totalTodos = user.totalTodos;
    _user.todoList = user.todoList;
    notifyListeners();
  }

  void updateUserField(dynamic value, String field) {
    switch (field) {
      case 'name':
        _user.name = value;
        break;
      case 'surname':
        _user.surname = value;
        break;
      case 'totalTodos':
        _user.totalTodos = value;
        break;
      case 'completedTodos':
        _user.completedTodos = value;
        break;
      case 'isDarkModeActive':
        _user.isDarkModeActive = value;
        break;
      default:
        log('ERROR: No se reconoce el campo [$field]');
    }
    notifyListeners();
  }
}
