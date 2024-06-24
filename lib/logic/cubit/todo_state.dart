part of 'todo_cubit.dart';

@immutable
class TodoState {
  final List<Todo> todos;

  TodoState(this.todos);
}

final class TodoInitial extends TodoState {
  final List<Todo> todos;

  TodoInitial(this.todos) : super(todos);
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message, List<Todo> todos) : super(todos);
}

class TodoToggled extends TodoState {
  TodoToggled(List<Todo> todos) : super(todos);
}

class TodoDeleted extends TodoState {
  TodoDeleted(List<Todo> todos) : super(todos);
}
