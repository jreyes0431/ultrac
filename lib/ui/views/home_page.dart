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

    User currentUser = User(
      name: data['name'],
      surname: data['surname'],
      totalTodos: data['totalTodos'],
      completedTodos: data['completedTodos'],
      isDarkModeActive: data['isDarkModeActive'] ?? false,
      todoList: todoListFromJson(data['todosJson'] ?? ''),
    );
    if (!mounted) return;

    context.read<UserProvider>().updateUser(currentUser);

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
    return Scaffold(
      backgroundColor: CustomColors.dark,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primary200,
        child: const Icon(Icons.add_rounded, color: CustomColors.text100),
        onPressed: () {
          context.read<UserProvider>().updateUserField(5, 'totalTodos');
          context.read<UserProvider>().updateUserField(3, 'completedTodos');
          //context.go('/nueva-tarea');
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
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.read<UserProvider>().user.name,
                        style: CustomTextStyles.medium,
                      ),
                      Column(
                        children: [
                          Switch(
                            value: context
                                .read<UserProvider>()
                                .user
                                .isDarkModeActive,
                            activeColor: CustomColors.text100,
                            inactiveThumbColor: CustomColors.accentDeep100,
                            onChanged: (bool value) {
                              setState(() {});
                              context
                                  .read<UserProvider>()
                                  .updateUserField(value, 'isDarkModeActive');
                            },
                          ),
                          Text(
                            'Modo ${context.read<UserProvider>().user.isDarkModeActive ? 'oscuro' : 'claro'}',
                            style: CustomTextStyles.disclaimerXs,
                          ),
                        ],
                      )
                    ],
                  ),
                  */
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      CustomDate.wellcomeMessage,
                      style: CustomTitleStyles.large.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
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
                            '${((currentUser.completedTodos * 100) / currentUser.totalTodos).roundToDouble()}% Tareas',
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
                        '''${currentUser.completedTodos.toInt()} de ${currentUser.totalTodos.toInt()}''',
                        style: CustomTextStyles.medium,
                      ),
                      Text(
                        " tareas completadas",
                        style: CustomTextStyles.medium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    color: CustomColors.primary200,
                    minHeight: 15,
                    borderRadius: BorderRadius.circular(12),
                    value: currentUser.completedTodos / currentUser.totalTodos,
                  ),
                  const SizedBox(height: 30),
                  if (isDataLoaded)
                    ...List.generate(
                      currentUser.todoList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: TodoCard(
                          title: context
                              .watch<UserProvider>()
                              .user
                              .todoList[index]
                              .title,
                          description: context
                              .watch<UserProvider>()
                              .user
                              .todoList[index]
                              .description,
                          bgColor: context
                              .watch<UserProvider>()
                              .user
                              .todoList[index]
                              .bgColor,
                        ),
                      ),
                    )
                  else
                    const CircularProgressIndicator.adaptive(
                      backgroundColor: CustomColors.primary200,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
