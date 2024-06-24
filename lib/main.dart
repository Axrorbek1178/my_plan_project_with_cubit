import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/bajarilgan_cubit.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/bajarilmagan_cubit.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/todo_cubit.dart';

import 'presentation/screens/todo_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoCubit(),
        ),
        BlocProvider(
          create: (context) => BajarilmaganCubit(context.read<TodoCubit>()),
        ),
        BlocProvider(
          create: (context) => BajarilganCubit(context.read<TodoCubit>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TodoScreen(),
      ),
    );
  }
}
