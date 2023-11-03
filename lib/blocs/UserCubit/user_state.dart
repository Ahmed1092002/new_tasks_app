part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class UserLoadingState extends UserState {}
class UserSuccessState extends UserState {


}


class UserErrorState extends UserState {}
class ProfileImagePickedSuccessState extends UserState {}
class ProfileImagePickedErrorState extends UserState {}
class uploadProfileImageErrorState extends UserState {}
class uploadProfileImageSuccessState extends UserState {}


class UserUpdateLoadingState extends UserState {}
class UserUpdateSuccessState extends UserState {}
class UserUpdateErrorState extends UserState {}
class ChangePasswordLoadingState extends UserState {}
class ChangePasswordSuccessState extends UserState {}
class ChangePasswordErrorState extends UserState {}


