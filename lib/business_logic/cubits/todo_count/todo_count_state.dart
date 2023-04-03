// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_count_cubit.dart';

class TodoCountState extends Equatable {
  final int count;

  const TodoCountState({
    required this.count,
  });

  factory TodoCountState.initial() {
    return const TodoCountState(count: 0);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [count];

  TodoCountState copyWith({
    int? count,
  }) {
    return TodoCountState(
      count: count ?? this.count,
    );
  }

  @override
  bool get stringify => true;
}
