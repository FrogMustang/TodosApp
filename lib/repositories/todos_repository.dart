import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:todos_app/models/todos.dart';
import 'package:todos_app/repositories/repositories.dart';
import 'package:todos_app/utils.dart';

class ITodoRepository implements TodosRepository {
  final Client _client = Client();

  @override
  Future<Either<String, List<Todo>>> fetchAllTodos() async {
    try {
      logger.i('FETCHING TODOS...');

      Response res = await _client.get(
        Uri.https(
          'jsonplaceholder.typicode.com',
          'todos',
        ),
      );

      if (res.statusCode == 200) {
        final List<dynamic> todosList = json.decode(res.body).map(
          (data) {
            return Todo.fromJSON(data);
          },
        ).toList();

        return Right(List<Todo>.from(todosList));
      }

      return Left(
        'Failed to FETCH all todos. ERROR: \n'
        '${res.reasonPhrase}',
      );
    } catch (error, stackTrace) {
      logger.e(
        'Failed to FETCH all todos',
        error: error,
        stackTrace: stackTrace,
      );

      return Left(
        'Failed to FETCH all todos. ERROR: \n'
        '$error',
      );
    }
  }

  @override
  Future<Either<String, bool>> createTodo({
    required Todo todo,
  }) async {
    try {
      logger.i('CREATING TODO...');

      Response res = await _client.post(
        Uri.https(
          'jsonplaceholder.typicode.com',
          'todos',
        ),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(todo.toJson()),
      );

      // we use 201 because the API fakes the creation
      if (res.statusCode == 201) {
        return const Right(true);
      }

      return Left(
        'Failed to CREATE new todo. ERROR: \n'
        '${res.reasonPhrase}',
      );
    } catch (error, stackTrace) {
      logger.e(
        'Failed to CREATE new todo.',
        error: error,
        stackTrace: stackTrace,
      );

      return Left(
        'Failed to CREATE new todo. ERROR: \n'
        '$error',
      );
    }
  }
}
