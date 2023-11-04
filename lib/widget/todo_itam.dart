import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_app/utils/Nafigator.dart';
import 'package:new_todo_app/views/details_todo_app_screan.dart';
import 'package:new_todo_app/widget/date_container.dart';

class TodoItam extends StatelessWidget {
  String? title = 'title';
  String? subtitle = 'subtitle';
  String? image = 'image';
  String? startDate;
  String? endDate;
  String? states;
  String? id;
  Color? color;
  void Function()? onDeleted;
  void Function()? onTap;
  TodoItam(
      {Key? key,
      this.title,
      this.subtitle,
      this.image,
      this.startDate,
      this.endDate,
      this.onTap,
      this.states,
      this.color,
      this.onDeleted,
      this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
            width: MediaQuery.of(context).size.width/1.2,

            decoration: BoxDecoration(
                color: Color(0xFFD6FDFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: color!,
                  width: 2,

                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(title!,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        )),
                    subtitle: Text(subtitle!,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                    trailing: IconButton(icon: Icon(Icons.delete),
iconSize: 30,

                      onPressed: onDeleted ,
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),

                  ),
                  if (image != null && image!.isNotEmpty && image!.length != 0)
                    CachedNetworkImage(
                      imageUrl: image!,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),

                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DateContainer(
                        iconDate: Icons.timer_outlined,
                        date: startDate,
                      ),
                      DateContainer(
                        iconDate: Icons.timer_off_outlined,
                        date: endDate,
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
