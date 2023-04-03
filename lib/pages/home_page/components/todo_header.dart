import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubits/todo_count/todo_count_cubit.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        BlocBuilder<TodoCountCubit, TodoCountState>(
          builder: (context, state) {
            print(state.toString());

            return Text(
              '${state.count} items left',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            );
          },
        ),
      ],
    );
  }
}
