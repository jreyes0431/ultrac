import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrac/model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenWidth = 0.0, screenHeigth = 0.0;

  @override
  void initState() {
    // TODO(jose): implement Todos lecture
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
                //TODO(jose): add todo list
              ],
            ),
          ),
        ),
      ),
    );
  }
}
