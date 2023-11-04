import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/TaskCubit/task_cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OutdatesCircularPercentIndicator extends StatelessWidget {
  const OutdatesCircularPercentIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        var cubit = TaskCubit.get(context);

        return CircularPercentIndicator(
          radius: 90.0,
          lineWidth: 13.0,
          animation: true,
          percent: (cubit.outDateTaskCount! / cubit.totalTaskCount) ,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Color(0xFF424242),
          center: Text(
            '${cubit.totalTaskCount}Tasks',
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }
}
