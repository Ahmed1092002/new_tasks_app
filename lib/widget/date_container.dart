import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DateContainer extends StatelessWidget {
  String? date ;
  IconData? iconDate;
   DateContainer({
    super.key,
    this.date,
    this.iconDate,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(

        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(iconDate,size: 30,),

            Text(date!,
              style: TextStyle(
                  fontSize: 14
              ),),
          ],
        ),
       color: MaterialStateProperty.all(Color(0xFFD6FDFC)),
      side: BorderSide(
        color: Color(0xFF9913AB),


      ),
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),

      ),




    );




    //   Container(
    //   width: 150,
    //   decoration: BoxDecoration(
    //       color: Color(0xFFD6FDFC),
    //       borderRadius: BorderRadius.circular(10),
    //       border: Border.all(
    //         color: Color(0xFF56A7E7),
    //       )),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       Icon(Icons.timer_outlined,size: 30,),
    //       Text(DateFormat.yMMMd().format(DateTime.now()),
    //       style: TextStyle(
    //         fontSize: 20
    //       ),),
    //     ]
    //   ),
    // );
  }
}
