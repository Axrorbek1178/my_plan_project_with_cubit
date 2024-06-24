part of 'bajarilgan_cubit.dart';

@immutable
sealed class BajarilganState {}

final class BajarilganInitial extends BajarilganState {}

final class BajarilganLoaded extends BajarilganState {
  final List<Todo> todos;
  BajarilganLoaded(this.todos);
}