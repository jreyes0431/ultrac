part of widgets;

class TodoCard extends StatefulWidget {
  const TodoCard({
    super.key,
    required this.bgColor,
    required this.index,
    this.title = '',
    this.description = '',
    this.isCompleted = false,
  });

  final Color bgColor;
  final String title;
  final String description;
  final bool isCompleted;
  final int index;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isCompleted = false;
  @override
  void initState() {
    super.initState();
    isCompleted = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = context.watch<UserProvider>().user;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 450,
        minHeight: 70,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 25),
                widget.title.isEmpty
                    ? const Spacer()
                    : Expanded(
                        child: Text(
                          widget.title,
                          overflow: TextOverflow.clip,
                          style: CustomTitleStyles.small.copyWith(
                            color: isCompleted
                                ? CustomColors.primary200
                                : Colors.black,
                            decoration:
                                isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    num newCompleted =
                        context.read<UserProvider>().completedTodos;
                    if (isCompleted) {
                      newCompleted -= 1;
                    } else {
                      newCompleted += 1;
                    }

                    if (newCompleted < 0) newCompleted = 0.0001;
                    setState(() {
                      isCompleted = !isCompleted;
                      currentUser.todoList[widget.index].isCompleted =
                          isCompleted;
                    });

                    context.read<UserProvider>().updateUserField(
                          newCompleted,
                          'completedTodos',
                        );
                    Data.updateUserField(
                      Data.jsonFromTodoList([...currentUser.todoList]),
                      'todosJson',
                    );
                  },
                  icon: Icon(
                    isCompleted
                        ? Icons.restart_alt
                        : Icons.check_circle_outline,
                    color: isCompleted ? CustomColors.primary200 : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    currentUser.todoList.removeAt(widget.index);
                    Data.updateUserField(
                      Data.jsonFromTodoList([...currentUser.todoList]),
                      'todosJson',
                    );

                    num newTotal = currentUser.todoList.length;
                    if (newTotal < 0) newTotal = 0.0001;

                    context
                        .read<UserProvider>()
                        .updateUserField(currentUser.todoList, 'todoList');

                    if (isCompleted) {
                      num newCompleted =
                          context.watch<UserProvider>().completedTodos;
                      newCompleted -= 1;
                      if (newCompleted < 0) newCompleted = 0.0001;
                      context
                          .read<UserProvider>()
                          .updateUserField(newCompleted, 'completedTodos');
                    }
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 25),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 25,
                top: 10,
              ),
              child: Align(
                alignment: const Alignment(-1, 0),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: CustomTextStyles.small.copyWith(
                    color: isCompleted ? CustomColors.primary200 : Colors.black,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
