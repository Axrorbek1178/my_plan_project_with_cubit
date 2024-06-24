part of 'bajarilmagan_cubit.dart';

@immutable
sealed class BajarilmaganState {
// final TodoCubit todos;
//
// BajarilmaganState(this.todos);
}

final class BajarilmaganInitial extends BajarilmaganState {
  // BajarilmaganInitial(super.todos);
}
final class BajarilmaganLoaded extends BajarilmaganState {
  final List<Todo> todos;
  BajarilmaganLoaded(this.todos);
}
