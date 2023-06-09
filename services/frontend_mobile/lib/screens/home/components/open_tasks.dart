import 'package:epictask/bloc/generics/generics_event.dart';
import 'package:epictask/repositories/task_repository.dart';
import 'package:epictask/screens/tasks/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/generics/generic_bloc.dart';
import '../../../bloc/generics/generic_state.dart';
import '../../../models/task_model/task_model.dart';

class OpenTasksWidget extends StatefulWidget {
  const OpenTasksWidget({super.key});

  @override
  State<OpenTasksWidget> createState() => _OpenTasksWidgetState();
}

class _OpenTasksWidgetState extends State<OpenTasksWidget> {
  late final GenericBloc<TaskModel, TaskRepository> bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<GenericBloc<TaskModel, TaskRepository>>(context);
    bloc.add(LoadingGenericData());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenericBloc<TaskModel, TaskRepository>, GenericState>(
        bloc: bloc,
        builder: (BuildContext context, GenericState state) {
          if (state is HasDataState) {
            print('Has data');
            final List<TaskModel> taskData = state.data as List<TaskModel>;
            return Column(
              children: List.generate(
                  taskData.length, (index) => TaskCard(task: taskData[index])),
            );
          } else {
            print('No data');
            return Container();
          }
        });
  }
}
