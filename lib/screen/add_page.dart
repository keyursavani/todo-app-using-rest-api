import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_using_rest_api/screen/todo_list.dart';

class AddTodoPage extends StatefulWidget{
  const AddTodoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return AddTodoPageState();
  }
}
class AddTodoPageState extends State<AddTodoPage>{
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: Text("Add Todo"),
       centerTitle: true,
       automaticallyImplyLeading: true,
     ),
     body: ListView(
       padding: const EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 30),
       children: [
         TextFormField(
           controller: titleController,
           decoration: const InputDecoration(
             hintText: 'Title'
           ),
         ),
         const SizedBox(height: 30,),
         TextFormField(
           controller: descriptionController,
           decoration: const InputDecoration(
             hintText: 'Description',
             floatingLabelBehavior: FloatingLabelBehavior.never,
           ),
           keyboardType: TextInputType.multiline,
           minLines: 5,
           maxLines: 8,
         ),
         const SizedBox(height: 50,),
         ElevatedButton(
             onPressed: submitData,
             child:const Text("Submit"),
         ),
       ],
     ),
   );
  }
  Future<void> submitData() async{

    // Get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description":description,
      "is_completed": false,
    };
    // Submit data to the server
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
        uri ,
        body: jsonEncode(body),
      headers: {'Content-Type':'application/json'},
    );
    // Show success or fail message based on status
    if(response.statusCode == 201){
      titleController.text = '';
      descriptionController.text = '';
      print("Creation Success");
      showSuccessMessage("Creation Success");
    }
    else{
      print("Creation Failed");
      print(response.body);
      showErrorMessage("Creation Failed");
    }
  }
  void  showSuccessMessage(String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void  showErrorMessage(String message){
    final snackBar = SnackBar(content:
    Text(
        message,
      style: const TextStyle(
        color: Colors.white
      ),
    ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
  // https://api.nstack.in/v1/todos?page=1&limit=10