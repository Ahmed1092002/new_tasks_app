import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:new_todo_app/data/user_data.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserProfile? user ;
  var Token;

  final storage = new FlutterSecureStorage();

  static LoginCubit get(context) => BlocProvider.of(context);
  login({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          print (value);
        //  user = await UserData.getUserProfile(value.user!.uid);
          await storage.write(key: 'uid', value: value.user!.uid);
          Token =   await storage.read(key: 'uid');
          print (  Token);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }

}
