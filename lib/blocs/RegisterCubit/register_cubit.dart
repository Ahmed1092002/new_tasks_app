import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:new_todo_app/data/user_data.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var Token;

  final storage = new FlutterSecureStorage();


  register({required String email, required String password, required String name}) {
    if (state is! RegisterInitial) {
      throw Exception('Cannot emit new states after calling close');
    }
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      createNewUser(email: email, password: password, name: name, uid: value.user!.uid);
      print (value);
      await storage.write(key: 'uid', value: value.user!.uid);
      Token =   await storage.read(key: 'uid');
      print (  Token);

    }).catchError((error) {
      emit(RegisterErrorState());
    });
  }

  createNewUser({required String email, required String password, required String name, required String uid}) {
    UserProfile userProfile = UserProfile(email: email,  fullName: name, uid: uid);
    emit(UserCreateLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).set(userProfile.toJson())
        .then((value) {
      emit(UserCreateSuccessState());
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(UserCreateErrorState());
    });
  }

}
