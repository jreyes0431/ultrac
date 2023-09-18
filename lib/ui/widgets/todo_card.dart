part of widgets;

class TodoCard extends StatefulWidget {
  const TodoCard({
    super.key,
    required this.bgColor,
    required this.index,
    required this.onTap,
    this.title = '',
    this.description = '',
  });

  final Color bgColor;
  final String title;
  final String description;
  final int index;
  final VoidCallback onTap;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late User currentUser;
  @override
  void initState() {
    currentUser = context.read<UserProvider>().user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 450,
        minHeight: 70,
      ),
      child: InkWell(
        onTap: widget.onTap,
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
                              color: context
                                      .watch<UserProvider>()
                                      .user
                                      .todoList[widget.index]
                                      .isCompleted
                                  ? CustomColors.primary200
                                  : Colors.black,
                              decoration: context
                                      .watch<UserProvider>()
                                      .user
                                      .todoList[widget.index]
                                      .isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentUser.todoList[widget.index].isCompleted =
                            !currentUser.todoList[widget.index].isCompleted;
                      });
                      context
                          .read<UserProvider>()
                          .updateUserField(currentUser.todoList, 'todoList');
                      Data.updateUserField(
                        Data.jsonFromTodoList([...currentUser.todoList]),
                        'todosJson',
                      );
                    },
                    icon: Icon(
                      context
                              .watch<UserProvider>()
                              .user
                              .todoList[widget.index]
                              .isCompleted
                          ? Icons.restart_alt
                          : Icons.check_circle_outline,
                      color: context
                              .watch<UserProvider>()
                              .user
                              .todoList[widget.index]
                              .isCompleted
                          ? CustomColors.primary200
                          : Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      currentUser.todoList.removeAt(widget.index);
                      context
                          .read<UserProvider>()
                          .updateUserField(currentUser.todoList, 'todoList');
                      Data.updateUserField(
                        Data.jsonFromTodoList([...currentUser.todoList]),
                        'todosJson',
                      );
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
                      color: context
                              .watch<UserProvider>()
                              .user
                              .todoList[widget.index]
                              .isCompleted
                          ? CustomColors.primary200
                          : Colors.black,
                      decoration: context
                              .watch<UserProvider>()
                              .user
                              .todoList[widget.index]
                              .isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
