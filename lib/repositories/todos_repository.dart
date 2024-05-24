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
}
