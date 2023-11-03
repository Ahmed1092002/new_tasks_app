import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_todo_app/blocs/TaskCubit/task_cubit.dart';
import 'package:new_todo_app/utils/Nafigator.dart';
import 'package:new_todo_app/views/todo_app_screan.dart';
import 'package:new_todo_app/widget/custom_button.dart';
import 'package:new_todo_app/widget/custom_text_field.dart';
import 'package:new_todo_app/widget/dropdown_button_item.dart';
import 'package:new_todo_app/widget/select_date_item.dart';

class AddImageItem extends StatelessWidget {
  AddImageItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        var cubit = TaskCubit.get(context);

        Widget ImageComponent;

        if (cubit.taskImage != null) {
          ImageComponent = Image.file(cubit.taskImage!);
        }
        else if (
        cubit.taskImageLink != null && cubit.taskImageLink!.isNotEmpty) {
          print (" task image ${cubit.taskImageLink!.length}");
          ImageComponent = CachedNetworkImage(
            imageUrl: cubit.taskImageLink!,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
        }

        else {

          ImageComponent = Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.photo_library_outlined,
                size: 120,
              ),
              Text(
                'Add Photo',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {

                cubit.pickProfileImage();
            },
            child: Container(
              width: 500,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFE040FC),
                  )),
              child: ImageComponent,
            ),
          ),
        );
      },
    );
  }
}
