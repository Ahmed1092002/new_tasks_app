import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:new_todo_app/data/post_model.dart';
import 'package:new_todo_app/data/status_enum.dart';
import '../../data/user_data.dart';
import '../../generated/l10n.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  final storage = FlutterSecureStorage();
  static TaskCubit get(context) => BlocProvider.of(context);
  String? Token;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  TextEditingController imageController = TextEditingController();
String ?sortState;

  String? taskStates;
  String? taskId;

  File? taskImage;

  String? taskImageLink ='';
 int? newTaskCount = 0;
 int? inProgressTaskCount = 0;
 int? outDateTaskCount = 0;

 int? completeTaskCount = 0;
  int totalTaskCount =0;
  var imagePicker = ImagePicker();
 pickProfileImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      taskImage = File(pickedFile.path);

      emit(ProfileImagePickedSuccessState());

    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  Future<void> uploadTaskImage() async {
    if (taskImage != null) {
      try {
        final taskImagePath = 'tasks images/${Uri.file(taskImage!.path).pathSegments.last}';
        final taskImageRef = firebase_storage.FirebaseStorage.instance.ref().child(taskImagePath);
        final uploadTask = taskImageRef.putFile(taskImage!);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();
        taskImageLink = downloadUrl;
        print (downloadUrl);
        print (taskImageLink);
        emit(uploadTaskImageSuccessState());
      } catch (error) {
        print(error);
        emit(uploadTaskImageErrorState());
      }
    } else {
      print('No profile image selected.');
      emit(uploadTaskImageErrorState());
    }
  }

  addTask({
    @required String? title,
    @required String? description,
    @required String? startDate,
    @required String? endDate,
    String? states ,
   String? image,
    // Add taskImageLink parameter
  }) async {
    Token = await storage.read(key: 'uid');

PostModel postmodel = PostModel(
  title: title,
  description: description,
  uid: Token,
  image: image,
  startDate: startDate,
  endDate: endDate,
  states: states ??  status.New.name.toString(),
  id: '',
  // Add taskImageLink parameter
);

    emit(AddNewTaskLoading());
    try {
      final taskRef = FirebaseFirestore.instance.collection('tasks');
      final taskDoc = await taskRef.add(postmodel.toJson());
      print(taskDoc.id);
      print('User Added Successfully');

      emit(AddNewTaskLSuccess());
    } catch (error) {
      print(error);

      emit(AddNewTaskError());
    }

  }

  List<PostModel> tasks = [];

  void getTaskData() async {
    Token = await storage.read(key: 'uid');

    if (FirebaseAuth.instance.currentUser!.uid != Token) {
      emit(GetTaskErrorState());
      return;
    } else
      {
        tasks=[];
        newTaskCount = 0;
        inProgressTaskCount = 0;
        outDateTaskCount = 0;
        completeTaskCount = 0;

        emit(GetTaskLoadingState());

        try {
          final taskSnapshot = await FirebaseFirestore.instance.collection('tasks')
              .where('uid', isEqualTo: Token)
              .get(

          );



          taskSnapshot.docs.forEach((element) {
            print(element.data());

            tasks.add(PostModel.fromJson(element.data(), element.id));
            print (tasks.length);
          });

          totalTaskCount = taskSnapshot.docs.length;
          print (totalTaskCount);
          dashboardCalculate();



          print(taskSnapshot.docs);
          emit(GetTaskSuccessState());
        } catch (error) {
          print(error);
          emit(GetTaskErrorState());
        }
      }

  }


  dashboardCalculate(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    // Get the total number of tasks


    newTaskCount =tasks.where((task) => task.states == 'New').length;
    completeTaskCount =tasks.where((task) => task.states == 'Done').length;
    for (int i = 0; i < totalTaskCount; i++) {
      if ((formatter.parse(tasks[i].endDate!).isBefore(now) &&
          tasks[i].states != 'Done') ||
          tasks[i].states != 'Archive'
      ) {
        inProgressTaskCount = inProgressTaskCount! + 1;
      }
      else if (formatter.parse(tasks[i].endDate!).isAfter(now) ||
          tasks[i].states != 'Archive'
      ) {
        outDateTaskCount = outDateTaskCount! + 1;
      }
    }
  }















filterItems({String? sortState}) async {





  final Token = await storage.read(key: 'uid');

  try {
    final taskSnapshot = await FirebaseFirestore.instance.collection('tasks')
        .where('uid', isEqualTo: Token)
        .where('states', isEqualTo: sortState)
        .get();
    taskSnapshot.docs.forEach((element) {
      print(element.data());
      tasks=[];
      print (tasks);
      tasks.add(PostModel.fromJson(element.data(), element.id));


      emit(sortTaskSuccessState());

    });

    } catch (error) {
      print(error);
      emit(sortTaskErrorState());
    }





}




  editTask({
    @required String? title,
    @required String? description,
    @required String? startDate,
    @required String? endDate,
    String? states ,
    @required String? taskId,
    String? image,
    // Add taskImageLink parameter
  }) async {
    emit(EditNewTaskLoading());
    Token = await storage.read(key: 'uid');
print (states);
    PostModel postmodel = PostModel(
      title: title,
      description: description,
      uid: Token,
      image: image != null && image != '' ? image : taskImageLink,
      startDate: startDate,
      endDate: endDate,
      states: states,
      id: taskId,
      // Add taskId parameter
    );
    try {
      final taskRef = FirebaseFirestore.instance.collection('tasks');
      await taskRef.doc(taskId).update(postmodel.toJson());
      print('User Edited Successfully');

      emit(EditNewTaskLSuccess());
    } catch (error) {
      print(error);

      emit(EditNewTaskError());
    }


  }



  dismiss() {


    taskImage = null;
    taskStates = '';
    taskId = '';
    taskImageLink = '';




    titleController.clear();
    descriptionController.clear();
    startDateController.clear();
    endDateController.clear();




  }


  void deleteTask({@required String? taskId}) async {
    emit(DeleteTaskLoadingState());
    try {
      final taskRef = FirebaseFirestore.instance.collection('tasks');
      await taskRef.doc(taskId).delete();
      print('User Deleted Successfully');

      emit(DeleteTaskSuccessState());
    } catch (error) {
      print(error);

      emit(DeleteTaskErrorState());
    }
  }








  changeLanguage( Locale locale) async {
    var storage = FlutterSecureStorage();
    await storage.write(key: 'languageCode', value: locale.languageCode);
    await storage.write(key: 'countryCode', value: locale.countryCode!);
    S.load(locale);
  }
  bool isArabic (){
    return Intl.getCurrentLocale() == 'ar_EG';

  }

  void ChangeLanguageConndation() {
    if(isArabic()){
      changeLanguage( Locale('en', 'US'));
      emit(ChangeLanguageSuccessState());
    }else {
      changeLanguage( Locale('ar', 'EG'));
      emit(ChangeLanguageSuccessState());
    }
  }










}
