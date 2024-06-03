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
  final _formKey = GlobalKey<FormState>();

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.black,
      body: BlocConsumer<TodosBloc, TodosState>(
        listenWhen: (previous, current) {
          return previous.status.isSubmissionInProgress &&
              (current.status.isSubmissionSuccess ||
                  current.status.isSubmissionFailure);
        },
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.pop(context);
          } else if (state.status.isSubmissionFailure) {
            logger.e('Failed to create a new TODO');

            CustomSnackBar.show(
              context,
              'Failed to create a new TODO',
              isError: true,
            );
          }
        },
        builder: (context, state) {
          return Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),

                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: CustomColors.white,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create Todo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: CustomColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// USER INPUT FOR NAME
                  Form(
                    key: _formKey,
                    child: FormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'Please provide a title';
                        }
                        return null;
                      },
                      builder: (formState) {
                        return Column(
                          children: [
                            TextField(
                              cursorColor: CustomColors.white,
                              style: const TextStyle(
                                color: CustomColors.white,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Title',
                                floatingLabelStyle: TextStyle(
                                  color: CustomColors.white,
                                ),
                                labelStyle: TextStyle(
                                  color: CustomColors.white,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: CustomColors.white,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: CustomColors.white,
                                    width: 1,
                                  ),
                                ),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(80),
                              ],
                              onChanged: (val) {
                                formState.didChange(val);

                                setState(() {
                                  name = val;
                                });
                              },
                            ),

                            // CUSTOM ERROR TEXT
                            if (formState.hasError) ...{
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CustomColors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        formState.errorText!,
                                        style: const TextStyle(
                                          color: CustomColors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        Icons.error_outline,
                                        color: CustomColors.black,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            },
                            const SizedBox(height: 20),

                            // CREATE BUTTON
                            CreateTodoButton(
                              formKey: _formKey,
                              todoName: name,
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CreateTodoButton extends StatelessWidget {
  const CreateTodoButton({
    super.key,
    required this.formKey,
    required this.todoName,
  });

  final GlobalKey<FormState> formKey;
  final String todoName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState?.validate() == true) {
          final Todo newTodo = Todo(
            id: 201 + Random().nextInt(200),
            title: todoName,
            completed: false,
          );

          getIt<TodosBloc>().add(
            TodoCreated(
              todo: newTodo,
            ),
          );
        }
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          CustomColors.lime,
        ),
        padding: WidgetStateProperty.all(
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
          color: CustomColors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
