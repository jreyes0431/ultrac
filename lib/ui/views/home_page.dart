part of views;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenWidth = 0.0;
  double screenHeigth = 0.0;
  bool isDataLoaded = false;

  void getData() async {
    await Future.delayed(
        const Duration(seconds: 1)); // Just for simulate charging
    Map<String, dynamic> data = await Data.getUserData();

    if (!mounted) return;

    context.read<UserProvider>().updateUserField(
        Data.todoListFromJson(data['todosJson'] ?? ''), 'todoList');

    isDataLoaded = true;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = context.watch<UserProvider>().user;
    log('HP completed es ${context.watch<UserProvider>().completedTodos}');
    return Scaffold(
      backgroundColor: CustomColors.dark,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primary200,
        child: const Icon(Icons.add_rounded, color: CustomColors.text100),
        onPressed: () {
          context.go('/nueva-tarea');
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  Text(
                    CustomDate.wellcomeMessage,
                    style: CustomTitleStyles.large.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 60,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Te damos la bienvenida al gestor de tareas',
                        style: CustomTextStyles.disclaimer,
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/ultric200.png',
                        height: 30,
                        width: 60,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  if (isDataLoaded) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              CustomDate.weekday,
                              style: CustomTextStyles.medium,
                            ),
                            Text(
                              CustomDate.dayMonthYear,
                              style: CustomTextStyles.disclaimer,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${((context.watch<UserProvider>().completedTodos * 100) / context.watch<UserProvider>().totalTodos).roundToDouble()}% Tareas',
                              style: CustomTextStyles.medium,
                            ),
                            Text(
                              'Completadas',
                              style: CustomTextStyles.disclaimer,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '''${context.watch<UserProvider>().completedTodos.toInt()} de ${context.watch<UserProvider>().totalTodos.toInt()}''',
                          style: CustomTextStyles.medium,
                        ),
                        Text(
                          " tareas completadas",
                          style: CustomTextStyles.medium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        color: CustomColors.primary200,
                        minHeight: 15,
                        value: context.watch<UserProvider>().completedTodos /
                            context.watch<UserProvider>().totalTodos,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ...List.generate(
                      currentUser.todoList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: TodoCard(
                          index: index,
                          title: currentUser.todoList[index].title,
                          description: currentUser.todoList[index].description,
                          bgColor: currentUser.todoList[index].bgColor,
                          isCompleted: currentUser.todoList[index].isCompleted,
                        ),
                      ),
                    ),
                  ] else
                    const CircularProgressIndicator.adaptive(
                      backgroundColor: CustomColors.primary200,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
