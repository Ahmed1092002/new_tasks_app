import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_todo_app/blocs/TaskCubit/task_cubit.dart';
import 'package:new_todo_app/utils/Nafigator.dart';
import 'package:new_todo_app/utils/page_name.dart';
import 'package:new_todo_app/views/todo_app_screan.dart';
import 'package:new_todo_app/widget/add_image_item.dart';
import 'package:new_todo_app/widget/custom_button.dart';
import 'package:new_todo_app/widget/custom_text_field.dart';
import 'package:new_todo_app/widget/dropdown_button_item.dart';
import 'package:new_todo_app/widget/select_date_item.dart';

class AddTodoAppScreanForm extends StatefulWidget {
  final String? pageName;

  AddTodoAppScreanForm({
    super.key,
    this.pageName,
  });

  @override
  State<AddTodoAppScreanForm> createState() => _AddTodoAppScreanFormState();
}

class _AddTodoAppScreanFormState extends State<AddTodoAppScreanForm> {
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();

  Future<String> _selectDate(
      BuildContext context, DateTime selectedDate) async {
    final now = DateTime.now();

    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final DateTime? picked = await showDatePicker(

        context: context,
        initialDate: selectedDate,
        firstDate: firstDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
    }
    final formattedDate = DateFormat('yyyy/MM/dd').format(selectedDate);

    return formattedDate.toString();
  }
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is AddNewTaskLSuccess) {
          navigateToScreenAndExit(context, TodoAppScrean());

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("success"),
            backgroundColor: Colors.green,
          ));
        } else if (state is AddNewTaskError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("error"),
            backgroundColor: Colors.red,
          ));
        } else if (state is EditNewTaskLSuccess) {
          navigateToScreenAndExit(context, TodoAppScrean());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("success"),
            backgroundColor: Colors.green,
          ));
        } else if (state is EditNewTaskError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("error"),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context, state) {
        var cubit = TaskCubit.get(context);

        return Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(children: [
            SizedBox(
              height: 16,
            ),
            CustomTextField(
              hint: 'title',
              icon: Icons.title,
              controller: cubit.titleController,
            ),
            SizedBox(
              height: 5,
            ),
            CustomTextField(
              hint: 'Description',
              icon: Icons.description,
              controller: cubit.descriptionController,
            ),
            SizedBox(
              height: 5,
            ),
            SelectDateItem(
              icon: Icons.timer_outlined,
              date: cubit.startDateController.text == ''
                  ? 'Start Date'
                  : cubit.startDateController.text,
              onTap: () async {
                cubit.startDateController.text =
                    await _selectDate(context, startDate);
              },
            ),
            SizedBox(
              height: 5,
            ),
            SelectDateItem(
              icon: Icons.timer_off_outlined,
              date: cubit.endDateController.text == ''
                  ? 'End Date'
                  : cubit.endDateController.text,
              onTap: () async {
                cubit.endDateController.text =
                    await _selectDate(context, endDate);
              },
            ),
            if (widget.pageName == 'Edit Task') DropdownButtonItem(
              pageName: widget.pageName,
            ),
            SizedBox(
              height: 5,
            ),
            AddImageItem(),
            SizedBox(
              height: 5,
            ),
            if (state is AddNewTaskLoading || state is EditNewTaskLoading)
              CircularProgressIndicator()
            else
              CustomButton(
                onPressed: () async {
                  if (widget.pageName == addTask) {
                    await cubit.uploadTaskImage();

                    try {
                      await cubit.addTask(
                        title: cubit.titleController.text,
                        description: cubit.descriptionController.text,
                        startDate: cubit.startDateController.text,
                        endDate: cubit.endDateController.text,
                        image: cubit.taskImageLink,
                      );
                      cubit.getTaskData();
                    } catch (error) {
                      // Handle error
                      print(error);
                    }
                  } else if (widget.pageName == 'Edit Task') {
                    await cubit.uploadTaskImage();

                    try {
                      await cubit.editTask(
                        title: cubit.titleController.text,
                        description: cubit.descriptionController.text,
                        startDate: cubit.startDateController.text,
                        endDate: cubit.endDateController.text,
                        states: cubit.taskStates,
                        taskId: cubit.taskId,
                        image: cubit.taskImageLink,
                      );
                      cubit.getTaskData();
                    } catch (error) {
                      // Handle error
                      print(error);
                    }
                  }
                },
                buttonName: widget.pageName,
              )
          ]),
        );
      },
    );
  }
}
