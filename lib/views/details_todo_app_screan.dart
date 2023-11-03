import 'package:flutter/material.dart';
import 'package:new_todo_app/widget/add_todo_app_screan_form.dart';

class TodoAppDetailsScrean extends StatelessWidget {
  String? pageName;
   TodoAppDetailsScrean({Key? key, this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("TodoAppDetailsScrean $pageName");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageName!,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFE040FC),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(child: AddTodoAppScreanForm(
        pageName: pageName,
      )),
    );
  }
}
