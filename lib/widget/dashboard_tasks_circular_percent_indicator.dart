import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/blocs/TaskCubit/task_cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'in_progress_circular_percent_indicator_circular_percent_indicator.dart';

class NewTaskesCircularPercentIndicator extends StatelessWidget {
  const NewTaskesCircularPercentIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        var cubit = TaskCubit.get(context);

        return CircularPercentIndicator(
          radius: 150.0,
          lineWidth: 13.0,
          animation: true,
          percent: (cubit.newTaskCount! / cubit.totalTaskCount),
          animationDuration: 10,
          addAutomaticKeepAlive: true,
           animateFromLastPercent: true,
          center: InProgressCircularPercentIndicator(),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Color(0xFF9C28B1),
        );
      },
    );
  }
}
