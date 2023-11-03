import 'package:flutter/material.dart';

class StatusTasksContainer extends StatelessWidget {
  Color? color;
  String? title;
   StatusTasksContainer({
    super.key,
    this.color,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(

        children: [
          Container(

            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color,

              borderRadius: BorderRadius.circular(10),
            )
          ),
          SizedBox(width: 10,),
          Text(title!)
        ],
      ),
    );
  }
}
