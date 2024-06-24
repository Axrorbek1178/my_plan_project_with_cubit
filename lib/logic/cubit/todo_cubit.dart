import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:my_plan_project_with_cubit/data/models/todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit()
      : super(TodoInitial([
          Todo(
              id: UniqueKey().toString(),
              title: "Go gaming club",
              isdone: false),
          Todo(id: UniqueKey().toString(), title: "Go shopping", isdone: false),
        ]));

  void addTodo(String title) {
    try {
      final todo = Todo(id: UniqueKey().toString(), title: title);
      final todos = state.todos;
      todos.add(todo);
      emit(TodoState(todos));
    } catch (e) {
      emit(TodoError("Hatolik sodir bo'ldi ", state.todos));
    }
  }

  void editTodo(Todo todo) {
    try {
      final todos = state.todos;
      final index = todos.indexWhere((element) => element.id == todo.id);
      todos[index] = todo;
      emit(TodoState(todos));
    } catch (e) {
      emit(TodoError("Xatolik sodir bo'ldi", state.todos));
    }
  }

  void toggleTodo(String id) {
    final todo = state.todos.firstWhere((element) => element.id == id);
    todo.isdone = !todo.isdone;
    emit(TodoToggled(state.todos));
    emit(TodoState(state.todos));
  }

  void deleteTodo(String id) {
    final todos = state.todos;
    todos.removeWhere((element) => element.id == id);
    emit(TodoState(state.todos));
    emit(TodoDeleted(state.todos));
  }

  List<Todo> searchTodos(String title) {
    return state.todos!
        .where((element) =>
            element.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
  }
}
