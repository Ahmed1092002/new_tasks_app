part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}
class AddNewTaskLoading extends TaskState {}
class AddNewTaskLSuccess extends TaskState {}
class AddNewTaskError extends TaskState {}

class EditNewTaskLoading extends TaskState {}
class EditNewTaskLSuccess extends TaskState {}
class EditNewTaskError extends TaskState {}
class ProfileImagePickedSuccessState extends TaskState {}

class ProfileImagePickedErrorState extends TaskState {}
class uploadTaskImageSuccessState extends TaskState {}
class uploadTaskImageErrorState extends TaskState {}
class GetTaskLoadingState extends TaskState {}
class GetTaskSuccessState extends TaskState {}
class GetTaskErrorState extends TaskState {}
class DeleteTaskLoadingState extends TaskState {}
class DeleteTaskSuccessState extends TaskState {}
class DeleteTaskErrorState extends TaskState {}

class sortTaskLoadingState extends TaskState {}
class sortTaskSuccessState extends TaskState {}
class sortTaskErrorState extends TaskState {}
class ChangeLanguageSuccessState extends TaskState {}
class ChangeLanguageErrorState extends TaskState {}
class ChangeLanguageLoadingState extends TaskState {}
