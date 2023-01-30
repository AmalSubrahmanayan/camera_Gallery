import 'package:camera_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'functions/db_functions.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await createDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue[900]),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
