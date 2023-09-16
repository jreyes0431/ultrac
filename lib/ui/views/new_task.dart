part of views;

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      context.go('/inicio');
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      size: 35,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Nueva tarea',
                    style: CustomTitleStyles.large,
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: TextFormField(
                    controller: titleController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Título de la tarea',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: TextFormField(
                    controller: contentController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText:
                          'Contenido de la tarea... Descripción detallada de lo que hay que hacer',
                      border: OutlineInputBorder(),
                      enabled: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 40,
                  width: 120,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColors.accentDeep100,
                    ),
                    child: Center(
                      child: Text(
                        'Guardar tarea',
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.medium
                            .copyWith(color: Colors.white),
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
