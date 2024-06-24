import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plan_project_with_cubit/data/models/todo.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/todo_cubit.dart';

class ManageTodo extends StatelessWidget {
  final Todo? todo;

  ManageTodo({super.key, this.todo});

  final _formKey = GlobalKey<FormState>();
  late String _title = "";

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (todo == null) {
        // BlocProvider.of<TodoCubit>(context).addTodo(_title);
        context.read<TodoCubit>().addTodo(_title);
      } else {
        context.read<TodoCubit>().editTodo(Todo(id: todo!.id, title: _title, isdone: todo!.isdone));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(todo);
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoError) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Xatolik!"),
                  content: Text(state.message),
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok")),
                  ],
                );
              });
        }
      },
      child: Form(
        key: _formKey,
        child: AlertDialog(
          content: Text("Yangi reja qo'shish"),
          actions: [
            TextFormField(
              initialValue: todo == null ? "" : todo!.title,
              onSaved: (newValue) {
                _title = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Iltimos reja kiriting";
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Reja Kiriting"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                    onPressed: () {
                      submit(context);
                    },
                    child: Text(todo == null ? "Add" : "Edit"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
