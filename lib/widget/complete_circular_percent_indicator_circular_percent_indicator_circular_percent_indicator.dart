import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/widget/outdates_circular_percent_indicator_circular_percent_indicator_circular_percent_indicator_circular_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../blocs/TaskCubit/task_cubit.dart';

class CompleteCircularPercentIndicator extends StatelessWidget {
  const CompleteCircularPercentIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        return CircularPercentIndicator(

          radius: 110.0,
          lineWidth: 13.0,
          animation: true,
          percent: (cubit.completeTaskCount! / cubit.totalTaskCount) ,
          animationDuration: 10,
          addAutomaticKeepAlive: true,
          animateFromLastPercent: true,

          center:
          OutdatesCircularPercentIndicator(),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Color(0xFF4CB050),
        );
      },
    );
  }
}
