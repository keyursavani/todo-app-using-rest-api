import 'package:flutter/material.dart';
import 'package:todo_app_using_rest_api/screen/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData.dark(),
     home: const ToDoListPage(),
   );
  }
}
