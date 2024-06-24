import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plan_project_with_cubit/data/const/tab_titles.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/bajarilgan_cubit.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/bajarilmagan_cubit.dart';
import 'package:my_plan_project_with_cubit/logic/cubit/todo_cubit.dart';
import 'package:my_plan_project_with_cubit/presentation/widgets/manage_todo.dart';
import 'package:my_plan_project_with_cubit/presentation/widgets/search_nar.dart';
import 'package:my_plan_project_with_cubit/presentation/widgets/todo_list_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _init = false;

  @override
  void didChangeDependencies() {
    if (!_init) {
      context.read<BajarilmaganCubit>().getBajarilmagan();
      context.read<BajarilganCubit>().getBajarilgan();
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void openManageTodo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ManageTodo();
        });
  }

  void openSearchBar(BuildContext context) {
    showSearch(context: context, delegate: SearchNar());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabTitles.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: const Text(
              "My plan app",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.limeAccent),
            ),
          ),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                openSearchBar(context);
              },
              icon: Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                openManageTodo(context);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.yellow,
                size: 30,
              ),
            ),
          ],
          bottom: TabBar(
              tabs: TabTitles.tabs
                  .map((e) =>
                  Tab(
                    text: e,
                  ))
                  .toList()),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (BuildContext context, index) {
                      return TodoListItem(todo: state.todos[index]);
                    });
              },
            ),
            BlocBuilder<BajarilmaganCubit, BajarilmaganState>(
                builder: (context, state) {
                  if (state is BajarilmaganLoaded) {
                    return state.todos.isEmpty
                        ? Center(
                      child: Text("Ro'yxatlar yo'q"),
                    )
                        : ListView.builder(
                        itemCount: state.todos.length,
                        itemBuilder: (BuildContext context, index) {
                          return TodoListItem(todo: state.todos[index]);
                        });
                  } else {
                    return Center(
                      child: Text("Ro'yxatlar yo'q"),
                    );
                  }
                }),
            BlocBuilder<BajarilganCubit, BajarilganState>(
              builder: (context, state) {
                if (state is BajarilganLoaded) {
                  return state.todos.isEmpty
                      ? Center(
                    child: Text("Ro'yxat yo'q"),
                  )
                      : ListView.builder(
                      itemCount: state.todos.length,
                      itemBuilder: (BuildContext context, index) {
                        return TodoListItem(todo: state.todos[index]);
                      });
                } else {
                  return Center(
                    child: Text("Ro'yxat yo'q"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
