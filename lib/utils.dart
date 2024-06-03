import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:todos_app/bloc/todos_bloc.dart';
import 'package:todos_app/colors.dart';
import 'package:todos_app/models/todos.dart';
import 'package:todos_app/repositories/todos_repository.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 5,
    errorMethodCount: 15,
  ),
);

final GetIt getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  getIt.registerLazySingleton<ITodoRepository>(
    () => ITodoRepository(),
  );

  getIt.registerSingleton<TodosBloc>(
    TodosBloc(
      getIt.get<ITodoRepository>(),
    ),
  );
}

/// Changes a single item at [index] inside the [initialList] and provides a copy list as result.
/// Only supports changing [Todo.completed] and [Todo.changeCompletedStatus]
List<Todo> changeItemInList({
  required List<Todo> initialList,
  required int index,
  bool? completed,
  FormzStatus? changeCompletedStatus,
}) {
  final List<Todo> newTodos = List.from(initialList);
  newTodos[index] = newTodos[index].copyWith(
    completed: completed,
    changeCompletedStatus: changeCompletedStatus,
  );

  return newTodos;
}

class CustomSnackBar {
  const CustomSnackBar();

  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
    int durationSec = 2,
  }) {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        padding: EdgeInsets.zero,
        backgroundColor: isError ? Colors.red : CustomColors.turq,
        content: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Center(
            child: Text(
              message.toUpperCase(),
              style: const TextStyle(
                color: CustomColors.white,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        duration: Duration(seconds: durationSec),
      ),
    );
  }
}
