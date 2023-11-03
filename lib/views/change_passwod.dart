import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/UserCubit/user_cubit.dart';
import 'package:new_todo_app/utils/Nafigator.dart';
import 'package:new_todo_app/widget/custom_button.dart';
import 'package:new_todo_app/widget/custom_text_field.dart';

import 'dashboard_tasks.dart';

class ChangePasswordScrean extends StatelessWidget {
  ChangePasswordScrean({Key? key}) : super(key: key);
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change Password", style: TextStyle(
              color: Colors.white),),

          backgroundColor: Color(0xFFE040FC),
          iconTheme: IconThemeData(color: Colors.white),

        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is ChangePasswordErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("error"),
                backgroundColor: Colors.red,
              )); } else if (state is ChangePasswordSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("success"),
                backgroundColor: Colors.green,    ));
              navigateToScreen(context, DashboardTasks()  );
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Change Password"),
                    SizedBox(height: 20,),

                    CustomTextField(
                      controller: passwordController,
                      hint: "Password",
                      icon: Icons.lock,

                    ),

                    SizedBox(height: 20,),
                    if (state is ChangePasswordLoadingState)
                      CircularProgressIndicator()
                    else
                    CustomButton(
                      buttonName: "Change Password",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          UserCubit.get(context).chanegPassword(
                              password: passwordController.text);
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}
