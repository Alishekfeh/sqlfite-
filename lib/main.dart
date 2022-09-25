import 'package:flutter/material.dart';
import 'package:sq_flite_packege/pages/add_notes.dart';
import 'package:sq_flite_packege/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes:{
        "addNotes":(context) =>const AddNotes()
      },
    );
  }
}

