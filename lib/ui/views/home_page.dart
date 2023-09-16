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
    Map<String, dynamic> data = await Data.getUserData();
    User currentUser = User(
      name: data['name'],
      surname: data['surname'],
      totalTodos: data['totalTodos'],
      completedTodos: data['completedTodos'],
      isDarkModeActive: data['isDarkModeActive'] ?? false,
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
    return Scaffold(
      backgroundColor: CustomColors.ligth, //TODO: implement dark mode
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.accentDeep100,
        child: const Icon(Icons.add_rounded),
        onPressed: () {
          context.read<UserProvider>().updateUserField(1, 'totalTodos');
          Data.updateUserField(1, 'totalTodos');
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.read<UserProvider>().user.name,
                    style: CustomTextStyles.medium,
                  ),
                  Column(
                    children: [
                      Switch(
                        value:
                            context.read<UserProvider>().user.isDarkModeActive,
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
              const SizedBox(height: 30),
              Text(
                context.read<DateProvider>().wellcomeMessage,
                style: CustomTitleStyles.large
                    .copyWith(color: CustomColors.accentDeep100),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.watch<DateProvider>().dayMonthYear,
                    style: CustomTextStyles.medium,
                  ),
                  Text(
                    '${(context.watch<UserProvider>().user.completedTodos * 100) / context.watch<UserProvider>().user.totalTodos}% completado',
                    style: CustomTextStyles.medium,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '''${context.watch<UserProvider>().user.completedTodos.toInt()} de ${context.watch<UserProvider>().user.totalTodos.toInt()}''',
                    style: CustomTextStyles.medium,
                  ),
                  const Text(" tareas completadas"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: LinearProgressIndicator(
                  color: CustomColors.accentDeep100,
                  borderRadius: BorderRadius.circular(12),
                  value: context.watch<UserProvider>().user.completedTodos /
                      context.watch<UserProvider>().user.totalTodos,
                ),
              ),
              Visibility(
                visible: isDataLoaded,
                replacement: const CircularProgressIndicator.adaptive(),
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
