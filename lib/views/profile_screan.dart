import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/UserCubit/user_cubit.dart';
import 'package:new_todo_app/generated/assets.dart';
import 'package:new_todo_app/utils/Nafigator.dart';
import 'package:new_todo_app/views/edit_profile_screan.dart';
import 'package:new_todo_app/widget/custom_button.dart';

class ProfileScrean extends StatefulWidget {
  const ProfileScrean({Key? key}) : super(key: key);

  @override
  State<ProfileScrean> createState() => _ProfileScreanState();
}

class _ProfileScreanState extends State<ProfileScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(

          'Profile',
          style: TextStyle(color: Colors.white),

        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFE040FC),
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is ProfileImagePickedErrorState) {
            UserCubit.get(context).getUserData();
          }
        },
        builder: (context, state) {


          var cubit = UserCubit
              .get(context);


          if ( cubit == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          else if (state is UserSuccessState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [

                          Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                             clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: cubit.user!.image == null || cubit.user!.image == '' ? Image.asset(
                              Assets.assetsStateAPILogo,
                              fit: BoxFit.cover,
                            ) :

                            CachedNetworkImage(
                              imageUrl: '${cubit.user!.image}',
                              placeholder: (context, url) => CircularProgressIndicator(),

                              errorWidget: (context, url, error) {

                                return Icon(Icons.error);
                              },
                            ),

                          ),



                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${cubit.user!.fullName}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${cubit.user!.email}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        buttonName: 'edit profile',
                        onPressed: () {

                          if (cubit.user!.image != null) {
                            cubit.profileImageLink = cubit.user!.image!;
                          }
                          else if (cubit.profileImageLink != null && cubit.profileImageLink!.isNotEmpty) {
                            cubit.profileImageLink = cubit.profileImageLink!;
                          }
                          else {
                            cubit.profileImageLink = '';
                          }
                          cubit.fullNameController.text = cubit.user!.fullName!;
                          cubit.emailController.text = cubit.user!.email!;
                          print ('${cubit.user!.image}');
                          print ('${cubit.user!.fullName}');
                          print ('${cubit.user!.email}');
                          print('${cubit.user!.uid}');
                          navigateToScreen(context, EditProfileScrean());
                        }
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Text('Profile');
        },
      ),
    );
  }
}
