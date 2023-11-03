import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/TaskCubit/task_cubit.dart';

import '../data/status_enum.dart';
import '../utils/page_name.dart';

class DropdownButtonItem extends StatefulWidget {
  String? pageName;

  DropdownButtonItem({Key? key, this.pageName}) : super(key: key);

  @override
  State<DropdownButtonItem> createState() => _DropdownButtonItemState();
}

class _DropdownButtonItemState extends State<DropdownButtonItem> {
  status? selectedCategory = status.New;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = TaskCubit.get(context);
          return DropdownButtonFormField(
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                label: Text('Status'),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              value: selectedCategory,
              items: status.values
                  .map((category) => DropdownMenuItem(
                      value: category, child: Text(category.name.toString())))
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                if (widget.pageName.toString() == 'Edit Task') {

                  setState(() {
                    cubit.taskStates = value.name.toString();

                    print(cubit.taskStates);
                    selectedCategory = value;

                  });
                }

                else if (widget.pageName == 'Todo App') {
                  setState(() {
                    cubit.sortState=value.name.toString();
                    print (  cubit.sortState);
                    selectedCategory = value;
                    print(selectedCategory);
                  }
                  );
                }
              });
        },
      ),
    );
  }
}
