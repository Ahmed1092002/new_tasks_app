import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/TaskCubit/task_cubit.dart';
import 'package:new_todo_app/utils/page_name.dart';
import 'package:new_todo_app/widget/todo_itam.dart';

import '../data/status_enum.dart';
import '../utils/Nafigator.dart';
import '../views/details_todo_app_screan.dart';

class TodoItemList extends StatelessWidget {
  const TodoItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is GetTaskLoadingState) {
          Center(child: CircularProgressIndicator());
        }
      },
      builder: (context, state) {
        var task = TaskCubit.get(context);
        if (task.tasks.length == 0) {
          return Center(
            child: Text('No Tasks Yet'),
          );
        }
        return ConditionalBuilder(
            condition: task.tasks.length > 0,
            builder: (context) => ListView.builder(
                itemCount: task.tasks.length,
                itemBuilder: (context, index) {
                  final taskStatus = task.tasks[index].states;


                  return TodoItam(
                    title: task.tasks[index].title,
                    subtitle: task.tasks[index].description,
                    image: task.tasks[index].image,
                    startDate: task.tasks[index].startDate,
                    endDate: task.tasks[index].endDate,
                    states: task.tasks[index].states,
                    id: task.tasks[index].id,
                    color: getStatusColor(taskStatus!),
                    onTap: () {
                      print(task.tasks[index].id);

                      task.dismiss();
                      task.titleController.text =
                          task.tasks[index].title.toString();
                      task.descriptionController.text =
                          task.tasks[index].description.toString();
                      task.startDateController.text =
                          task.tasks[index].startDate.toString();
                      task.endDateController.text =
                          task.tasks[index].endDate.toString();
                      task.taskStates = task.tasks[index].states.toString();
                      task.taskImageLink = task.tasks[index].image.toString();

                      task.taskId = task.tasks[index].id.toString();
                      navigateToScreen(
                          context,
                          TodoAppDetailsScrean(
                            pageName:'Edit Task',
                          ));
                    },
                    onDeleted: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Task'),
                            content: Text(
                                'Are you sure you want to delete this task?'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  task.deleteTask(
                                      taskId: task.tasks[index].id);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );


                }),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  getStatusColor(String taskStatus) {
    if (taskStatus == "New" || taskStatus == "new") {
      return Color(0xFF9C28B1);
    }
    if (taskStatus == "Done") {
      return Color(0xFF4CB050);
    }
    if (taskStatus == "Archive") {
      return Colors.grey;
    }

    // New,Done,Archive
  }
}
