import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/UserCubit/user_cubit.dart';
import 'package:new_todo_app/views/profile_screan.dart';
import 'package:new_todo_app/widget/custom_text_field.dart';

import '../generated/assets.dart';
import '../utils/Nafigator.dart';
import '../widget/custom_button.dart';

class EditProfileScrean extends StatefulWidget {
   EditProfileScrean({Key? key}) : super(key: key);

  @override
  State<EditProfileScrean> createState() => _EditProfileScreanState();
}

class _EditProfileScreanState extends State<EditProfileScrean> {
GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFE040FC),
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserUpdateLoadingState) {
            Center(child: CircularProgressIndicator());
          }
          if (state is UserUpdateSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("success"),
              ),
            );
            UserCubit.get(context).getUserData();
            navigateToScreen(context, ProfileScrean());
          }
          if (state is UserUpdateErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("error"),
              ),
            );
          }
          if (state is ProfileImagePickedErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("error"),
              ),
            );
          }
          if (state is ProfileImagePickedSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("success"),
              ),
            );
          }
          if (state is uploadProfileImageSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("success"),
              ),
            );
          }
        },
        builder: (context, state) {
          var cubitData = UserCubit.get(context);
          var profileImage = UserCubit.get(context).profileImage;

          Widget ImageComponent;
          if (profileImage != null) {
            ImageComponent = Image.file(profileImage);
          }
          else if (cubitData.profileImageLink != null &&
              cubitData.profileImageLink!.isNotEmpty) {
            ImageComponent = CachedNetworkImage(
              imageUrl: cubitData.profileImageLink!,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            );
          } else {
            ImageComponent = Image.asset(Assets.assetsStateAPILogo);
          }

          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: SingleChildScrollView(

              child: Center(
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                    Stack(
                      children: [
                        Container(
                          height: 300,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ImageComponent,
                        ),
                        Positioned(
                            bottom: 50,
                            left: 140,
                            child: ElevatedButton(
                              onPressed: () {
                                UserCubit.get(context).pickProfileImage();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(10),
                              ),
                              child: Icon(Icons.edit),
                            ))
                      ],
                    ),
                    CustomTextField(
                      controller: cubitData.fullNameController,
                      hint: 'Full Name',
                      icon: Icons.person,
                    ),
                    CustomTextField(
                      controller: cubitData.emailController,
                      hint: 'Email',
                      icon: Icons.email,
                    ),
                    CustomButton(
                        buttonName: 'edit profile',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                          } else {
                            setState(() {
                              autovalidateMode =
                                  AutovalidateMode.onUserInteraction;
                            });
                            return;
                          }
                          if (cubitData.profileImage != null) {
                            await cubitData.uploadProfileImage();

                          }

await  cubitData.updateUserProfile(
                            fullName: cubitData.fullNameController.text,
                            email: cubitData.emailController.text,
                            profileImageLink: cubitData.profileImageLink,
                          );
                          cubitData.getUserData();

                        })
                ],
              ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
