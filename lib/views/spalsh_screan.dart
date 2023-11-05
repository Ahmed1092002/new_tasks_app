import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:new_todo_app/blocs/UserCubit/user_cubit.dart';
import 'package:new_todo_app/generated/assets.dart';
import 'package:new_todo_app/views/dashboard_tasks.dart';

import '../blocs/TaskCubit/task_cubit.dart';
import 'login_screan.dart';

// enum SplashTransition {
//   slideTransition,
//   scaleTransition,
//   rotationTransition,
//   sizeTransition,
//   fadeTransition,
//   decoratedBoxTransition
// }
enum PageTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
}

class SpalshScrean extends StatefulWidget {
  SpalshScrean({Key? key}) : super(key: key);

  @override
  State<SpalshScrean> createState() => _SpalshScreanState();
}

class _SpalshScreanState extends State<SpalshScrean> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TaskCubit.get(context).getTaskData();
      UserCubit.get(context).getUserData();
    });
  }
  @override
  var Token;

  final storage = new FlutterSecureStorage();

  Widget build(BuildContext context) {
    return

      BlocProvider(
        create: (context) => UserCubit(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return AnimatedSplashScreen.withScreenFunction(
                splash: Image.asset(Assets.stateAPILogo,),

                screenFunction: () async {
                  Token = await storage.read(key: 'uid');

                  if (Token == null && FirebaseAuth.instance.currentUser == null) {

                    return LoginScrean();
                  }
                  else {
                    // UserCubit.get(context).getUserData();
                    //
                    // TaskCubit.get(context).getTaskData();


                    return DashboardTasks();
                  }
                },

                animationDuration: Duration(seconds: 2),
                duration: 3,

                splashTransition: SplashTransition.fadeTransition

            );
          },
        ),
      );
  }
}
