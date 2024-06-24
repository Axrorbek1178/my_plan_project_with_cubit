import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plan_project_with_cubit/data/models/todo.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/todo_cubit.dart';

part 'bajarilmagan_state.dart';

class BajarilmaganCubit extends Cubit<BajarilmaganState> {
  late final StreamSubscription  todoSub;//obunachi
  final TodoCubit todoCubit;
  BajarilmaganCubit(this.todoCubit) : super(BajarilmaganInitial()){
    todoSub = todoCubit.stream.listen((TodoState state){
      getBajarilmagan();
    });
  }

  void getBajarilmagan() {
    final todos = todoCubit.state.todos.where((e) => !e.isdone).toList();
    
    emit(BajarilmaganLoaded(todos));
  }
}
