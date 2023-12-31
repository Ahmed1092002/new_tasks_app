import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/utils/Nafigator.dart';
import 'package:new_todo_app/views/dashboard_tasks.dart';
import 'package:new_todo_app/widget/custom_button.dart';
import 'package:new_todo_app/widget/custom_text_field.dart';

import '../blocs/RegisterCubit/register_cubit.dart';
import '../blocs/TaskCubit/task_cubit.dart';
import '../blocs/UserCubit/user_cubit.dart';


class RegisterScreanForm extends StatelessWidget {
  RegisterScreanForm({
    super.key,
  });

  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("error"),
            backgroundColor: Colors.red,
          ));
        } else if (state is RegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("success"),
            backgroundColor: Colors.green,
          ));
          TaskCubit.get(context).getTaskData();
          UserCubit.get(context).getUserData();
        navigateToScreenAndExit(context, DashboardTasks());
        }

      },
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(children: [
                CustomTextField(
                  hint: 'name',
                  controller: cubit.nameController,
                  icon: Icons.person,
                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  hint: 'email',
                  controller: cubit.emailController,
                  icon: Icons.email,

                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  hint: 'password',
                  controller: cubit.passwordController,
                  icon: Icons.lock,
                ),
                SizedBox(
                  height: 16,
                ),
                if (state is RegisterLoadingState)
                  CircularProgressIndicator()
                else
                CustomButton(
                  buttonName: 'Register',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      cubit.register(
                          name: cubit.nameController.text,
                          email: cubit.emailController.text,
                          password: cubit.passwordController.text);
                      


                      print('valid');
                    } else {
                      print('not valid');
                    }
                  },
                )
              ]));
        },
      ),
    );
  }
}
