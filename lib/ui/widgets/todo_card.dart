part of widgets;

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.bgColor,
    this.title = '',
    this.description = '',
  });

  final Color bgColor;
  final String title;
  final String description;

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
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 25),
                title.isEmpty
                    ? const Spacer()
                    : Expanded(
                        child: Text(
                          title,
                          overflow: TextOverflow.clip,
                          style: CustomTitleStyles.small.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle_outline),
                ),
                IconButton(
                  onPressed: () {
                    currentUser.todoList.removeWhere(
                      (element) =>
                          element.description == description &&
                          element.title == title,
                    );
                    Data.removeTask(currentUser);

                    num newTotal = currentUser.totalTodos - 1;
                    if (newTotal < 0) newTotal = 0.0001;

                    context
                        .read<UserProvider>()
                        .updateUserField(newTotal, 'totalTodos');

                    context
                        .read<UserProvider>()
                        .updateUserField(currentUser.todoList, 'todoList');
                  },
                  icon: const Icon(Icons.delete_outline),
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
                  description,
                  textAlign: TextAlign.justify,
                  style: CustomTextStyles.small.copyWith(
                    color: Colors.black,
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
