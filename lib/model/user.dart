part of model;

class User {
  String name;
  String surName;
  num totalTodos;
  num completedTodos;

  User({
    this.name = 'Anónimo',
    this.surName = '',
    this.completedTodos = 0.0001,
    this.totalTodos = 0.0001,
  });
}
