import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:todos_app/bloc/todos_bloc.dart';
import 'package:todos_app/colors.dart';
import 'package:todos_app/repositories/todos_repository.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 5,
    errorMethodCount: 15,
  ),
);

Color getRandomColor() {
  return CustomColors.colors[Random().nextInt(CustomColors.colors.length)];
}

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
