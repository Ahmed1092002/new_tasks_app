import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/LoginCubit/login_cubit.dart';
import 'package:new_todo_app/utils/Nafigator.dart';
import 'package:new_todo_app/views/dashboard_tasks.dart';
import 'package:new_todo_app/views/register_screan.dart';
import 'package:new_todo_app/widget/custom_button.dart';
import 'package:new_todo_app/widget/custom_text_field.dart';


class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("error"),
            backgroundColor: Colors.red,
          ));
        }
        else if (state is LoginSuccessState) {
          navigateToScreenAndExit(context, DashboardTasks());

        }      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
                children: [
                  CustomTextField(
                    hint: 'email',
                    controller: cubit.emailController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hint: 'password',
                    controller: cubit.passwordController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                      children: [
                        Text('Don\'t have an account?', style: TextStyle(
                            fontSize: 20
                        )),
                        TextButton(onPressed: () {
                          navigateToScreen(context, RegisterScrean());
                        },
                          child: Text('Register', style: TextStyle(
                              fontSize: 20,
                              color: Color(
                                  0xFF56A7E7
                              )
                          )
                          ),
                        ),


                      ]

                  ),
                  if (state is LoginLoadingState)
                    CircularProgressIndicator()
                  else
                  CustomButton(
                    buttonName: 'login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        cubit.login(
                            email: cubit.emailController.text,
                            password: cubit.passwordController.text);
                        print('valid');
                      } else {
                        print('not valid');
                      }

                    },
                  ),

                ]
            )
        );
      },
    );
  }
}
