import 'package:flutter/material.dart';

class SelectDateItem extends StatelessWidget {
  String? date;
  IconData? icon;
  void Function()? onTap;
   SelectDateItem({Key? key, this.date, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
     onTap:onTap ,
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.07,
decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),
            border: Border.all(

            ),

          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(icon),
                SizedBox(
                  width: 10,
                ),
              Text(date!,
                style: TextStyle(
                  fontSize: 20,
                ),),
                SizedBox(
                  width: 10,
                ),

              ],
            ),
          )
        ),
      ),
    );
  }
}
