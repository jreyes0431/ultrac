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
  TextEditingController contentController = TextEditingController();

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
                    'Nueva tarea',
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
                    controller: contentController,
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
                      contentController.text.isEmpty) return;
                  //Gotta do this here because the context is not available outside the build method (bad thing about provider)
                  User currentUser = context.read<UserProvider>().user;
                  currentUser.todoList = [
                    ...currentUser.todoList,
                    Todo(
                      title: titleController.text,
                      description: contentController.text,
                      bgColor: bgColor,
                    ),
                  ];
                  Data.addNewtask(currentUser);
                  context.go('/inicio');
                },
                child: SizedBox(
                  height: 40,
                  width: 120,
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
                      child: Text(
                        'Guardar tarea',
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.medium
                            .copyWith(color: CustomColors.text100),
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
