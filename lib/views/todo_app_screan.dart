import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:new_todo_app/blocs/TaskCubit/task_cubit.dart';
import 'package:new_todo_app/utils/Nafigator.dart';
import 'package:new_todo_app/utils/page_name.dart';
import 'package:new_todo_app/views/dashboard_tasks.dart';
import 'package:new_todo_app/views/details_todo_app_screan.dart';
import 'package:new_todo_app/views/login_screan.dart';
import 'package:new_todo_app/widget/sort_model_sheet.dart';


import '../blocs/UserCubit/user_cubit.dart';
import '../widget/drawer_item.dart';
import '../widget/todo_item_list.dart';

class TodoAppScrean extends StatefulWidget {
  const TodoAppScrean({Key? key}) : super(key: key);

  @override
  State<TodoAppScrean> createState() => _TodoAppScreanState();
}

class _TodoAppScreanState extends State<TodoAppScrean> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     TaskCubit.get(context).getTaskData();
  //     UserCubit.get(context).getUserData();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        var cubit = TaskCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Todo App', style: TextStyle(color: Colors.white),),
            backgroundColor: Color(0xFFE040FC),
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              IconButton(onPressed: () {
                showModalBottomSheet(context: context,
                    builder: (Context) {
                      return SortModelSheet(
                          pageName: 'Todo App'
                      );
                    });
              },
                  icon: Icon(Icons.sort)),

              IconButton(onPressed: () {
                navigateToScreen(context, DashboardTasks());
              },
                  icon: Icon(Icons.login_sharp)),
              IconButton(onPressed: () {
                cubit.getTaskData();
              },
                  icon: Icon(Icons.refresh))
            ],
          ),
          drawer: DrawerItem(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateToScreen(context, TodoAppDetailsScrean(
                pageName: 'Add Task',
              ));

              cubit.dismiss();
            },
            backgroundColor: Color(0xFFE040FC),
            child: Icon(Icons.add, color: Colors.white,),

          ),
          body: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                TaskCubit.get(context).getTaskData();
              },
              edgeOffset: 100,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              backgroundColor: Colors.white,


              color: Color(0xFFE040FC),


              child: TodoItemList()),
        );


      },
    );
  }
}
