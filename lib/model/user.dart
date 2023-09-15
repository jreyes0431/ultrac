part of model;

class User {
  String name;
  String surname;
  num totalTodos;
  num completedTodos;

  User({
    this.name = 'Anónimo',
    this.surname = '',
    this.completedTodos = 0.0001,
    this.totalTodos = 0.0001,
  });
}
