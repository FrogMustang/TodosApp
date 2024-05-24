import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:todos_app/models/todos.dart';
import 'package:todos_app/repositories/repositories.dart';
import 'package:todos_app/utils.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc(this._repo) : super(const TodosState()) {
    on<AllTodosFetched>(_onAllTodosFetched);
  }

  final TodosRepository _repo;

  Future<void> _onAllTodosFetched(
    AllTodosFetched event,
    Emitter<TodosState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );

    final Either<String, List<Todo>> res = await _repo.fetchAllTodos();

    res.fold(
      (error) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            todos: [],
          ),
        );
      },
      (todos) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
            todos: todos,
          ),
        );

        logger.d(
          'FETCHED ALL TODOS: \n'
          '${state.todos}',
        );
      },
    );
  }
}
