import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/cubits/filtered_todo_list/filtered_todo_list_cubit.dart';
import 'package:todo_app/business_logic/cubits/todo_count/todo_count_cubit.dart';
import 'package:todo_app/business_logic/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app/business_logic/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app/business_logic/cubits/todo_search/todo_search_cubit.dart';

import 'pages/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider(
          create: (context) => TodoCountCubit(
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
            initialTodoListLength:
                BlocProvider.of<TodoListCubit>(context).state.todoList.length,
          ),
        ),
        BlocProvider(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider(
          create: (context) => FilteredTodoListCubit(
            BlocProvider.of<TodoSearchCubit>(context),
            BlocProvider.of<TodoFilterCubit>(context),
            BlocProvider.of<TodoListCubit>(context),
            BlocProvider.of<TodoListCubit>(context).state.todoList,
          ),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: HomePage(),
      ),
    );
  }
}
