import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/LoginCubit/login_cubit.dart';
import 'package:new_todo_app/widget/login_form.dart';

import '../widget/logo_column.dart';


class LoginScrean extends StatelessWidget {
  const LoginScrean({Key? key}) : super(key: key);

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
