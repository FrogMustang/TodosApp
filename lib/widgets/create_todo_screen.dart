import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:todos_app/bloc/todos_bloc.dart';
import 'package:todos_app/colors.dart';
import 'package:todos_app/models/todos.dart';
import 'package:todos_app/utils.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({
    super.key,
    todosBloc,
  });

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SafeArea(
        child: BlocConsumer<TodosBloc, TodosState>(
            listenWhen: (previous, current) {
          return previous.status.isSubmissionInProgress &&
              (current.status.isSubmissionSuccess ||
                  current.status.isSubmissionFailure);
        }, listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 0),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                  const Text(
                    'CREATE TODO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// USER INPUT FOR NAME
                  TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(80),
                    ],
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // CREATE BUTTON
                  Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          final Todo newTodo = Todo(
                            id: 201 + Random().nextInt(200),
                            title: name,
                            completed: false,
                          );

                          getIt<TodosBloc>().add(
                            TodoCreated(
                              todo: newTodo,
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.amber,
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 5,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Create TODO',
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
