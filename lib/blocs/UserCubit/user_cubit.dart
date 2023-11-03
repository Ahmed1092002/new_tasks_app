import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:new_todo_app/data/user_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);
  UserProfile? user;
  File? profileImage;
  String? profileImageLink = '';
  var imagePicker = ImagePicker();
  String ?token;

  final storage =   FlutterSecureStorage();





  getUserData()  async {
    token=await storage.read(key:'uid' );
    print(token);
    emit(UserLoadingState());
      print('User Loading State');
      FirebaseAuth.instance.currentUser!.uid;
     await FirebaseFirestore.instance
        .collection('users')
        .doc(      token
     )
        .get()
        .then((value) {
      print(value.data());
      user = UserProfile.fromJson(value.data()!);
      emit(UserSuccessState());
    }).catchError((error) {
      print(error);
      emit(UserErrorState());
    });
    print(user!.image);
  }

  Future<void> pickProfileImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(ProfileImagePickedSuccessState());

    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }


  uploadProfileImage() {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value);
          profileImageLink = value;
          updateUserProfile();
          emit(uploadProfileImageSuccessState());
        });
      })
          .catchError((error) {
            print(error);
        emit(uploadProfileImageErrorState());
      });
    } else {
      print('No profile image selected.');
      emit(uploadProfileImageErrorState());
    }
  }

  updateUserProfile() {
 // user=UserProfile(email: user!.email, fullName: user!.fullName, uid: user!.uid, image: profileImageLink);
    if (user != null && profileImageLink != null) {
      emit(UserUpdateLoadingState());

      FirebaseFirestore.instance.collection('users').doc(user!.uid).update(
          // user!.toJson()
      {

        'image': profileImageLink,
      }
      )
          .then((value) {
print('User Updated Successfully');
print(user!.toJson());


        getUserData();
emit(UserUpdateSuccessState());

      })
          .catchError((error) {
            print(error);
        emit(UserUpdateErrorState());
      });
    } else {
      print('User or profile image link is null.');
      emit(UserUpdateErrorState());
    }
  }
  chanegPassword({required String password}) async {
    emit(ChangePasswordLoadingState());
    FirebaseAuth.instance.currentUser!.updatePassword(password).then((value) {
      emit(ChangePasswordSuccessState());
    }).catchError((error) {
      print(error);
      emit(ChangePasswordErrorState());
    });
  }
}
