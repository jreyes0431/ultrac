import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrac/model/model.dart';
import 'package:ultrac/util/util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenWidth = 0.0, screenHeigth = 0.0;
  bool isDataLoaded = false;

  void setUser() async {
    Map<String, dynamic> data = await Data.getUserData();
    User currentUser = User(
      name: data['name'],
      surname: data['surname'],
      totalTodos: data['totalTodos'],
      completedTodos: data['completedTodos'],
    );
    if (!mounted) return;
    context.read<UserProvider>().updateUser(currentUser);
    isDataLoaded = true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () {
          log('pressed');
        },
      ),
      body: Visibility(
        visible: true,
        replacement: const CircularProgressIndicator.adaptive(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(context.read<UserProvider>().user.name),
                    //TODO: Add switch button for dark and light mode
                  ],
                ),
                Text(context.read<DateProvider>().wellcomeMessage),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.watch<DateProvider>().ddmmyyyy),
                    Text(
                      '${(context.watch<UserProvider>().user.completedTodos * 100) / context.watch<UserProvider>().user.totalTodos}% completado',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: [
                      Text(
                        '${context.watch<UserProvider>().user.totalTodos.toInt()}',
                      ),
                      const Text("Tareas completadas"),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: LinearProgressIndicator(
                    value: context.watch<UserProvider>().user.completedTodos /
                        context.watch<UserProvider>().user.totalTodos,
                  ),
                ),
                Visibility(
                  child: Container(),
                  visible: isDataLoaded,
                  replacement: const CircularProgressIndicator.adaptive(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
