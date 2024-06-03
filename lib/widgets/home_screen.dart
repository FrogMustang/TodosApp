import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:todos_app/bloc/todos_bloc.dart';
import 'package:todos_app/colors.dart';
import 'package:todos_app/models/todos.dart';
import 'package:todos_app/widgets/create_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.black,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: CustomColors.dark,
            ),

            // SCREEN TITLE
            Container(
              height: 100,
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: CustomColors.dark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Text(
                'ALL TODOs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: CustomColors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // TODOs LIST
            const Expanded(
              child: TodosList(),
            ),
            const SizedBox(height: 20),

            // CREATE BUTTON
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateTodoScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  CustomColors.lime,
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 10,
                  ),
                ),
              ),
              child: const Icon(
                Icons.add,
                color: CustomColors.black,
                size: 40,
              ),
            ),
            SizedBox(height: 15 + MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}

class TodosList extends StatefulWidget {
  const TodosList({super.key});

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            final Todo todo = state.todos[index];
            bool completed = todo.completed;

            return Opacity(
              key: Key(todo.title + todo.id.toString()),
              opacity: completed ? 0.8 : 1.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 15,
                ),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: completed ? CustomColors.dark : CustomColors.lime,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      // DIVIDER LINE
                      VerticalDivider(
                        color:
                            completed ? CustomColors.white : CustomColors.dark,
                        thickness: 5,
                      ),

                      // CHECKBOX / LOADING INDICATOR
                      if (todo.changeCompletedStatus ==
                          FormzStatus.submissionInProgress) ...{
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: CupertinoActivityIndicator(
                              color: completed
                                  ? CustomColors.white
                                  : CustomColors.dark,
                            ),
                          ),
                        ),
                      } else ...{
                        Checkbox(
                          activeColor: CustomColors.white,
                          checkColor: CustomColors.dark,
                          value: completed,
                          onChanged: (bool? val) {
                            context.read<TodosBloc>().add(
                                  TodoCompletedChanged(
                                    index: index,
                                    completed: val ?? false,
                                  ),
                                );
                          },
                        ),
                      },

                      // TITLE AND DETAILS
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TODOs TITLE
                            Flexible(
                              child: Text(
                                todo.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: completed
                                      ? CustomColors.white
                                      : CustomColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            // TODOs DETAILS
                            Text(
                              'ID: ${todo.id}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14,
                                color: completed
                                    ? CustomColors.white
                                    : CustomColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
