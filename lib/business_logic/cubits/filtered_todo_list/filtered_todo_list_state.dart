// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, sort_constructors_firs
part of 'filtered_todo_list_cubit.dart';

class FilteredTodoListState extends Equatable {
  final List<Todo> filteredList;
  const FilteredTodoListState({
    required this.filteredList,
  });
  
  @override
  // TODO: implement props
  List<Object> get props => [filteredList];


  FilteredTodoListState copyWith({
    List<Todo>? filteredList,
  }) {
    return FilteredTodoListState(
      filteredList: filteredList ?? this.filteredList,
    );
  }

  @override
  bool get stringify => true;
  }

