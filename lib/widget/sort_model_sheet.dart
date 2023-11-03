import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/TaskCubit/task_cubit.dart';
import 'package:new_todo_app/data/status_enum.dart';
import 'package:new_todo_app/widget/custom_button.dart';

import 'dropdown_button_item.dart';

class SortModelSheet extends StatefulWidget {
  String? pageName;
   SortModelSheet({Key? key, this.pageName}) : super(key: key);

  @override
  State<SortModelSheet> createState() => _SortModelSheetState();
}

class _SortModelSheetState extends State<SortModelSheet> {

  @override
  Widget build(BuildContext context) {
    print ("SortModelSheet ${widget.pageName}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text("Status",style: TextStyle(
                fontSize: 30,

              ),),
            ),
          DropdownButtonItem(
            pageName: widget.pageName,
          ),
            SizedBox(
              height: 16,
            ),
            BlocConsumer<TaskCubit, TaskState>(
  listener: (context, state) {
    if (state is sortTaskLoadingState){
       Center(child: CircularProgressIndicator());
    }
  },
  builder: (context, state) {
    var cubit = TaskCubit.get(context);
    return CustomButton(
      buttonName: 'Apply Filter',
      onPressed: () {
        cubit.filterItems(sortState:  cubit.taskStates);
              Navigator.pop(context);
      },
    );
  },
)
          ],
        ),
      ),
    );
  }
}
