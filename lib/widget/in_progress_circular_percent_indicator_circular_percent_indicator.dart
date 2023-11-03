import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/widget/complete_circular_percent_indicator_circular_percent_indicator_circular_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../blocs/TaskCubit/task_cubit.dart';

class InProgressCircularPercentIndicator extends StatelessWidget {
  const InProgressCircularPercentIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        return CircularPercentIndicator(
          radius: 130.0,
          lineWidth: 13.0,
          animation: true,
          percent: (cubit.inProgressTaskCount! / cubit.tasks.length) ,
          animationDuration: 10,
          addAutomaticKeepAlive: true,
          animateFromLastPercent: true,

          center:
          CompleteCircularPercentIndicator(),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Color(0xFF2196F3),
        );
      },
    );
  }
}
