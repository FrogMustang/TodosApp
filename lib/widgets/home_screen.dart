import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/todos_bloc.dart';
import 'package:todos_app/colors.dart';
import 'package:todos_app/models/todos.dart';
import 'package:todos_app/repositories/todos_repository.dart';
import 'package:todos_app/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc(
        ITodoRepository(),
      )..add(const AllTodosFetched()),
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            return Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    'ALL TODOs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TodosList(
                      state: state,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TodosList extends StatelessWidget {
  const TodosList({
    super.key,
    required this.state,
  });

  final TodosState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: state.todos.length,
      itemBuilder: (context, index) {
        return TodoItem(todo: state.todos[index]);
      },
    );
  }
}

class TodoItem extends StatefulWidget {
  const TodoItem({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late bool completed;

  @override
  void initState() {
    super.initState();
    completed = widget.todo.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: completed ? 0.3 : 1.0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        margin: const EdgeInsets.only(
          top: 20,
        ),
        decoration: BoxDecoration(
          color:
              CustomColors.colors[widget.todo.id % CustomColors.colors.length],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Checkbox(
              value: completed,
              onChanged: (_) {
                setState(() {
                  completed = !completed;
                });
              },
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                widget.todo.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
