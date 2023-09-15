part of model;

class UserProvider extends ChangeNotifier {
  final User _user = User();

  User get user => _user;

  void updateUser(User user) {
    _user.name = user.name;
    _user.surName = user.surName;
    _user.completedTodos = user.completedTodos;
    _user.totalTodos = user.totalTodos;
    notifyListeners();
  }

  void updateUserField(dynamic value, String field) {
    switch (field) {
      case 'name':
        _user.name = value;
        break;
      case 'surName':
        _user.surName = value;
        break;
      case 'totalTodos':
        _user.totalTodos = value;
        break;
      case 'completedTodos':
        _user.completedTodos = value;
        break;
      default:
    }
  }
}
