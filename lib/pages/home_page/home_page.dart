import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/cubits/todo_filter/todo_filter_cubit.dart';

import '../../business_logic/cubits/todo_search/todo_search_cubit.dart';
import '../../business_logic/models/todo.dart';
import '../../utils/debounce.dart';
import 'components/create_todo.dart';
import 'components/show_todos.dart';
import 'components/todo_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const TodoHeader(),
              const CreateTodo(),
              SearchAndFilterTodo(),
              const ShowTodos(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchAndFilterTodo extends StatelessWidget {
  SearchAndFilterTodo({Key? key}) : super(key: key);
  final debounce = Debounce(milliseconds: 1000);

  Widget _buildTextButton(
      BuildContext context, String text, Filter appFilter, Color textColor) {
    return TextButton(
        onPressed: () {
          BlocProvider.of<TodoFilterCubit>(context).changeFilter(appFilter);
        },
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search todos...',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              debounce.run(() {
                context.read<TodoSearchCubit>().search(newSearchTerm);
              });
            }
          },
        ),
        const SizedBox(height: 10.0),
        BlocBuilder<TodoFilterCubit, TodoFilterState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTextButton(
                  context,
                  'All',
                  Filter.all,
                  state.filter == Filter.all ? Colors.blue : Colors.grey,
                ),
                _buildTextButton(
                  context,
                  'Active',
                  Filter.active,
                  state.filter == Filter.active ? Colors.blue : Colors.grey,
                ),
                _buildTextButton(
                  context,
                  'Completed',
                  Filter.completed,
                  state.filter == Filter.completed ? Colors.blue : Colors.grey,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
