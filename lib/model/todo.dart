part of model;

/// Todo model
class Todo {
  String title;
  String description;
  bool isCompleted;
  Color bgColor;

  Todo({
    /// Constructor with default values
    this.title = '',
    this.description = '',
    this.isCompleted = false,
    this.bgColor = const Color(0xFFfff3b0),
  });
}
