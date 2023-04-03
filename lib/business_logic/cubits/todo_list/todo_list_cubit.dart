import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/business_logic/models/todo.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String desc) {
    final List<Todo> newList = [...state.todoList];
    newList.add(Todo(desc: desc));
    emit(state.copyWith(todoList: newList));
  }

  void toggleTodo(String id) {
    final newTodos = state.todoList.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todoList: newTodos));
  }

  void changeTodo(String desc, String id) {
    final List<Todo> newList = state.todoList.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          desc: desc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todoList: newList));
  }

  void removeTodo(Todo todo) {
    final newTodos = state.todoList.where((Todo t) => t.id != todo.id).toList();

    emit(state.copyWith(todoList: newTodos));
  }
}
