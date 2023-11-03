import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/RegisterCubit/register_cubit.dart';
import 'package:new_todo_app/utils/Nafigator.dart';
import 'package:new_todo_app/views/login_screan.dart';
import 'package:new_todo_app/widget/logo_column.dart';
import 'package:new_todo_app/widget/register_screan_form.dart';


class RegisterScrean extends StatelessWidget {
  const RegisterScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    navigateToScreen(context, LoginScrean());
                  }, icon: Icon(Icons.arrow_back_ios)),
                  Spacer(
                    flex: 1,
                  )
                ],
              ),

              LogoColumn(
                pageName: 'Register',
              ),
              RegisterScreanForm(),
            ],
          ),
        ),
      ),
    );
  }
}
