import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/UserCubit/user_cubit.dart';
import 'package:new_todo_app/generated/assets.dart';
import 'package:new_todo_app/views/change_passwod.dart';
import 'package:new_todo_app/views/login_screan.dart';
import 'package:new_todo_app/views/profile_screan.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/Nafigator.dart';

class DrawerItem extends StatefulWidget {
  DrawerItem({Key? key}) : super(key: key);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // String? name ;
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,

        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: BlocProvider(
              create: (context) => UserCubit()..getUserData(),
              child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is ProfileImagePickedErrorState) {
                    UserCubit.get(context).getUserData();
                  }
                },
                builder: (context, state) {
                  var cubit = UserCubit.get(context).user;
                  if (cubit == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UserSuccessState) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                            ),
                            clipBehavior: Clip.hardEdge,
                            child: CachedNetworkImage(
                              imageUrl: '${cubit.image}',
                              fit: BoxFit.cover,
                              fadeInDuration: Duration(seconds: 1),
                              useOldImageOnUrlChange: true,
                              placeholderFadeInDuration: Duration(seconds: 1),

                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) {
                                return Icon(Icons.error);
                              },
                            ),
                          ),
                          Text(
                            '${cubit.fullName}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                  return Text('Profile');
                },
              ),
            ),
          ),
          ListTile(
            title: const Text('Profile'),
            leading: Icon(Icons.person),
            selected: _selectedIndex == 0,
            onTap: () {
              // Update the state of the app
              _onItemTapped(0);
              // Then close the drawer
              navigateToScreen(context, ProfileScrean());
            },
          ),
          ListTile(
            title: const Text('Change Password'),
            leading: Icon(Icons.password),
            selected: _selectedIndex == 1,
            onTap: () {
              // Update the state of the app
              _onItemTapped(1);
              // Then close the drawer
              navigateToScreen(context, ChangePasswordScrean());
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: Icon(Icons.logout),
            selected: _selectedIndex == 2,
            onTap: () async {
              // Update the state of the app
              _onItemTapped(2);
              // Then close the drawer

              await FirebaseAuth.instance.signOut();
              await storage.delete(key: 'uid');
              Navigator.pop(context);
              navigateToScreenAndExit(context, LoginScrean());

            },
          ),
        ],
      ),
    );
  }
}
