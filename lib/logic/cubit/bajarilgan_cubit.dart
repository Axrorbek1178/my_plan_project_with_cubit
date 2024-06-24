import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plan_project_with_cubit/data/models/todo.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/bajarilmagan_cubit.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/todo_cubit.dart';

part 'bajarilgan_state.dart';

class BajarilganCubit extends Cubit<BajarilganState> {
  late final StreamSubscription todoSub;
  final TodoCubit todoCubit;
  BajarilganCubit(this.todoCubit) : super(BajarilganInitial()) {
    todoSub = todoCubit.stream.listen((TodoState state) {
      getBajarilgan();
    });
  }

  void getBajarilgan() {
    final todos =
        todoCubit.state.todos.where((element) => element.isdone).toList();
    emit(BajarilganLoaded(todos));
  }
}
