import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:new_todo_app/widget/status_tasks_container.dart';
import 'package:new_todo_app/views/todo_app_screan.dart';
import 'package:new_todo_app/widget/status_tasks_container.dart';

import '../blocs/TaskCubit/task_cubit.dart';
import '../generated/l10n.dart';
import '../utils/Nafigator.dart';
import '../widget/custom_button.dart';
import '../widget/dashboard_tasks_circular_percent_indicator.dart';

class DashboardTasks extends StatefulWidget {
  const DashboardTasks({Key? key}) : super(key: key);

  @override
  State<DashboardTasks> createState() => _DashboardTasksState();
}

class _DashboardTasksState extends State<DashboardTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is GetTaskLoadingState) {
          Center(child: CircularProgressIndicator());
        }
      },
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    cubit.ChangeLanguageConndation();
                  });
                },
                icon: Icon(Icons.translate),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.2  ,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).dashboardTasks,
                      style: TextStyle(fontSize: 30),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          NewTaskesCircularPercentIndicator(),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatusTasksContainer(
                          title: S.of(context).newTasks,
                          color: Colors.purple,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        StatusTasksContainer(
                          title: S.of(context).inProgress,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        StatusTasksContainer(
                          title: S.of(context).completed,
                          color: Colors.greenAccent,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        StatusTasksContainer(
                          title: S.of(context).outdated,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    CustomButton(
                      buttonName: S.of(context).goToTasks,
                      onPressed: () {
                        navigateToScreen(context, TodoAppScrean());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}