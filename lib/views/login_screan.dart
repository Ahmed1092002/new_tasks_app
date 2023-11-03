import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/LoginCubit/login_cubit.dart';
import 'package:new_todo_app/blocs/TaskCubit/task_cubit.dart';
import 'package:new_todo_app/blocs/UserCubit/user_cubit.dart';
import 'package:new_todo_app/widget/login_form.dart';

import '../widget/logo_column.dart';


class LoginScrean extends StatefulWidget {
  const LoginScrean({Key? key}) : super(key: key);

  @override
  State<LoginScrean> createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean> {
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
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              LogoColumn(
                pageName: 'login',
              ),

              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
