import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrac/model/providers/todo_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrac/util/util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors.primary100,
        ),
      ),
    );
  }
}
