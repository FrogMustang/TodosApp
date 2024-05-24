import 'package:dartz/dartz.dart';
import 'package:todos_app/models/todos.dart';

abstract class TodosRepository {
  Future<Either<String, List<Todo>>> fetchAllTodos();

  Future<Either<String, bool>> createTodo({
    required Todo todo,
  });
}
