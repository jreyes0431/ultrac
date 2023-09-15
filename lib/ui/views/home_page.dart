import 'dart:developer';

import 'package:flutter/material.dart';

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
          child: Column(
            children: <Widget>[
              const Text("Tu gran lista de tareas"),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(DateTime.now().toLocal().toString()),
                  Spacer(),
                  Text('% completado'),
                  const SizedBox(width: 20),
                ],
              ),
              const Row(
                children: [Text("X"), Text("Tareas")],
              ),
              const LinearProgressIndicator(
                value: 70 / 100,
              ),
              //TODO(jose): add todo list
            ],
          ),
        ),
      ),
    );
  }
}
