// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/business_logic/cubits/todo_list/todo_list_cubit.dart';

part 'todo_count_state.dart';

class TodoCountCubit extends Cubit<TodoCountState> {
  final TodoListCubit todoListCubit;

  late final StreamSubscription todoListCubitSubscribtion;

  final int initialTodoListLength;

  TodoCountCubit({
    required this.todoListCubit,
    required this.initialTodoListLength,
  }) : super(TodoCountState(count: initialTodoListLength)) {
    todoListCubitSubscribtion = todoListCubit.stream.listen((todoListState) {
      final int currentActiveTodoCount = todoListState.todoList
          .where((element) {
            return !element.completed;
          })
          .toList()
          .length;
      emit(state.copyWith(count: currentActiveTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListCubitSubscribtion.cancel();
    // TODO: implement close
    return super.close();
  }
}
