import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/todo_cubit.dart';
import 'package:my_plan_project_with_cubit/presentation/widgets/todo_list_item.dart';

class SearchNar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // tozalash knopkasi
    return [
      TextButton(
          onPressed: () {
            query = '';
          },
          child: Text("Clear"))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // orqaga qaytish knopkasi
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // javobni chiqarish
    final todos = context.read<TodoCubit>().searchTodos(query);
    return todos.isEmpty
        ? Center(
            child: Text("BUnday reja yo'q"),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoListItem(todo: todos[index]);
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // takliflar
    if (query.isNotEmpty) {
      final todos = context.read<TodoCubit>().searchTodos(query);
      return todos.isEmpty
          ? Center(
              child: Text("Bunday reja yo'q"),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoListItem(todo: todos[index]);
              });
    } else {
      return Container();
    }
  }
}
