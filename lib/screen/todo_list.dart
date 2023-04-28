import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app_using_rest_api/screen/add_page.dart';
import 'package:http/http.dart' as http;

class ToDoListPage extends StatefulWidget{
  const ToDoListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ToDoListPageState();
  }
}
class ToDoListPageState extends State<ToDoListPage>{
  List items = [];
  bool isLoading = true;
  @override
  void initState(){
    super.initState();
    fetchTodo();
  }
  @override
  Widget build(BuildContext context) {
    print(items);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        child :  const Center(child:   CircularProgressIndicator(),),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
            itemCount: items.length,
              itemBuilder: (context ,index){
              final item = items[index] as Map;
                return  ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}'),),
                  title: item['title'] == "keyur" ?
                  Text(item['title'])
                  : Text("Not Match"),
                  subtitle: Text(item['description']),
                );
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed:navigateToAddPage,
          label: const Text("Add Todo")
      ),
    );
  }
  void navigateToAddPage(){
    final route = MaterialPageRoute(builder: (context){
      return const AddTodoPage();
    });
    Navigator.push(context, route);
  }
  Future<void> fetchTodo() async {
    final url = "https://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    final response =  await http.get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}