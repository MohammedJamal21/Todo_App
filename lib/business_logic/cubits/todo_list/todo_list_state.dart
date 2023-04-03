// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, sort_constructor
part of 'todo_list_cubit.dart';

class TodoListState extends Equatable {
  final List<Todo> todoList;

  const TodoListState({
    required this.todoList,
  });

  factory TodoListState.initial() {
    return TodoListState(todoList: [
      Todo(desc: 'Hello'),
      Todo(desc: 'choni'),
      Todo(desc: 'hey'),
    ]);
  }

  @override
  // TODO: implement props
  List<Object> get props => [todoList];

  TodoListState copyWith({
    List<Todo>? todoList,
  }) {
    return TodoListState(
      todoList: todoList ?? this.todoList,
    );
  }

  @override
  bool get stringify => true;
}
