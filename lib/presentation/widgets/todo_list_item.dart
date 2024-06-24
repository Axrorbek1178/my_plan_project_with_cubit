import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plan_project_with_cubit/data/models/todo.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/todo_cubit.dart';
import 'package:my_plan_project_with_cubit/presentation/widgets/manage_todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  TodoListItem({super.key, required this.todo});

  void openManageTodo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ManageTodo(todo: todo);
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
          onPressed: () {
            context.read<TodoCubit>().toggleTodo(todo.id);
          },
          icon: Icon(
              todo.isdone ? Icons.check_circle : Icons.check_circle_outline)),
      title: Text(
        todo.title,
        style: TextStyle(
            decoration:
                todo.isdone ? TextDecoration.lineThrough : TextDecoration.none),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.read<TodoCubit>().deleteTodo(todo.id);
            },
            icon: const Icon(Icons.delete_forever),
          ),
          IconButton(
            onPressed: () {
              openManageTodo(context);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
