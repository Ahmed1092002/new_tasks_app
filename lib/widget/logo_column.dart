import 'package:flutter/material.dart';

class LogoColumn extends StatelessWidget {
  String ?pageName;
   LogoColumn({
    super.key,
    this.pageName
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Image.asset(
          'assets/State _ API/logo.png',
          width: 200,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          pageName!,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
