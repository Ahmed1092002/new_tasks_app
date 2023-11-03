import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/UserCubit/user_cubit.dart';
import 'package:new_todo_app/generated/assets.dart';

class ProfileScrean extends StatelessWidget {
  const ProfileScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(

          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFE040FC),
      ),
      body: BlocProvider(
        create: (context) => UserCubit()..getUserData(),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is ProfileImagePickedErrorState) {
              UserCubit.get(context).getUserData();
            }
          },
          builder: (context, state) {


            var cubit = UserCubit
                .get(context)
                .user;

            if ( cubit == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            else if (state is UserSuccessState) {
              return Center(
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
                          child: CachedNetworkImage(
                            imageUrl: '${cubit.image}',
                            placeholder: (context, url) => CircularProgressIndicator(),

                            errorWidget: (context, url, error) {

                              return Icon(Icons.error);
                            },
                          ),

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
                          )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${cubit.fullName}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${cubit.email}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
            return Text('Profile');
          },
        ),
      ),
    );
  }
}
