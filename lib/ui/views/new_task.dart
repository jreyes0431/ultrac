part of views;

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Widget circleClickableColor(Color color) {
    return SizedBox(
      width: 20,
      height: 20,
      child: InkWell(
        onTap: () {
          setState(() {
            bgColor = color;
          });
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Color bgColor = CustomColors.primary300;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late User currentUser;

  @override
  void initState() {
    currentUser = context.read<UserProvider>().user;
    if (context.read<UserProvider>().isEditing) {
      titleController.text =
          currentUser.todoList[currentUser.indexEditing].title;
      descriptionController.text =
          currentUser.todoList[currentUser.indexEditing].description;
      bgColor = currentUser.todoList[currentUser.indexEditing].bgColor;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context
                          .read<UserProvider>()
                          .updateUserField(-1, 'indexEditing');
                      context.go('/inicio');
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      size: 35,
                      color: CustomColors.primary200,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    context.watch<UserProvider>().isEditing
                        ? 'Editar tarea'
                        : 'Nueva tarea',
                    style: CustomTitleStyles.large,
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: CustomTextInput(
                    controller: titleController,
                    hintText: 'Título de la tarea',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: CustomTextInput(
                    controller: descriptionController,
                    maxLines: 5,
                    hintText:
                        'Contenido de la tarea... Descripción detallada de lo que hay que hacer',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    const Spacer(),
                    Text(
                      'Color',
                      style: CustomTextStyles.medium,
                    ),
                    const SizedBox(width: 10),
                    circleClickableColor(CustomColors.primary100),
                    const SizedBox(width: 10),
                    circleClickableColor(CustomColors.accentDeep100),
                    const SizedBox(width: 10),
                    circleClickableColor(CustomColors.accent100),
                    const SizedBox(width: 10),
                    circleClickableColor(CustomColors.primary300),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  if (titleController.text.isEmpty &&
                      descriptionController.text.isEmpty) return;
                  //Gotta do this here because the context is not available outside the build method (bad thing about provider)
                  if (context.read<UserProvider>().isEditing) {
                    currentUser.todoList[currentUser.indexEditing] = Todo(
                      title: titleController.text,
                      description: descriptionController.text,
                      bgColor: bgColor,
                    );
                    context
                        .read<UserProvider>()
                        .updateUserField(-1, 'indexEditing');
                  } else {
                    currentUser.todoList = [
                      ...currentUser.todoList,
                      Todo(
                        title: titleController.text,
                        description: descriptionController.text,
                        bgColor: bgColor,
                      ),
                    ];
                  }
                  Data.updateUserField(
                    Data.jsonFromTodoList([...currentUser.todoList]),
                    'todosJson',
                  );
                  context.go('/inicio');
                },
                child: SizedBox(
                  height: 40,
                  width: context.read<UserProvider>().isEditing ? 180 : 140,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColors.primary200,
                      boxShadow: const [
                        BoxShadow(
                          color: CustomColors.dark,
                          spreadRadius: 0.2,
                          blurRadius: 0.2,
                          offset: Offset(0, 1.5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          context.watch<UserProvider>().isEditing
                              ? 'Guardar cambios'
                              : 'Guardar tarea',
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.medium
                              .copyWith(color: CustomColors.text100),
                        ),
                      ),
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
