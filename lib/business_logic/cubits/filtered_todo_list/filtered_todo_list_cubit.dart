// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/business_logic/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app/business_logic/cubits/todo_search/todo_search_cubit.dart';

import '../../models/todo.dart';
import '../todo_filter/todo_filter_cubit.dart';

part 'filtered_todo_list_state.dart';

class FilteredTodoListCubit extends Cubit<FilteredTodoListState> {
  final TodoListCubit todoListCubit;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;

  late final StreamSubscription todoListSubscription;
  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;

  final List<Todo> initialTodoList;

  FilteredTodoListCubit(
    this.todoSearchCubit,
    this.todoFilterCubit,
    this.todoListCubit,
    this.initialTodoList,
  ) : super(
          FilteredTodoListState(
            filteredList: initialTodoList,
          ),
        ) {
    todoListSubscription = todoListCubit.stream.listen((state) {
      showFilteredList();
    });

    todoFilterSubscription = todoFilterCubit.stream.listen((state) {
      showFilteredList();
    });

    todoSearchSubscription = todoSearchCubit.stream.listen((state) {
      showFilteredList();
    });
  }

  void showFilteredList() {
    List<Todo> filteredTodos;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        filteredTodos = todoListCubit.state.todoList
            .where((Todo todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        filteredTodos = todoListCubit.state.todoList
            .where((Todo todo) => todo.completed)
            .toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todoListCubit.state.todoList;
        break;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm.toLowerCase()))
          .toList();
    }

    emit(state.copyWith(filteredList: filteredTodos));
  }
}
