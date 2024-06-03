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
    on<TodoCreated>(_onTodoCreated);
    on<TodoCompletedChanged>(_onTodoCompletedChanged);
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

  Future<void> _onTodoCreated(
    TodoCreated event,
    Emitter<TodosState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );

    final Either<String, bool> res = await _repo.createTodo(todo: event.todo);

    res.fold(
      (error) {
        logger.e(
          'Failed to CREATE new todo. ERROR: \n'
          '$error',
        );

        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
          ),
        );
      },
      (created) {
        if (created) {
          logger.d("TODOS BEFORE: ${state.todos}");

          final List<Todo> newTodos = List.from(state.todos);
          newTodos.insert(0, event.todo);

          logger.d("NEW TODOS: $newTodos");

          emit(
            state.copyWith(
              status: FormzStatus.submissionSuccess,
              todos: newTodos,
            ),
          );

          logger.d(
            'CREATED NEW TODO: \n'
            '${event.todo}',
          );
        }
      },
    );
  }

  Future<void> _onTodoCompletedChanged(
    TodoCompletedChanged event,
    Emitter<TodosState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
        todos: changeItemInList(
          initialList: state.todos,
          index: event.index,
          changeCompletedStatus: FormzStatus.submissionInProgress,
        ),
      ),
    );

    // Mock sending a request to the API and finish the TODOs
    final Either<String, bool> res = await Future.delayed(
      const Duration(seconds: 1),
      () {
        return const Right(true);
      },
    );

    res.fold(
      (error) {
        logger.e(
          'Failed to mark TODO as ${event.completed}. ERROR: \n'
          '$error',
        );

        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            todos: changeItemInList(
              initialList: state.todos,
              index: event.index,
              changeCompletedStatus: FormzStatus.submissionFailure,
            ),
          ),
        );
      },
      (completed) {
        if (completed) {
          emit(
            state.copyWith(
              status: FormzStatus.submissionSuccess,
              todos: changeItemInList(
                initialList: state.todos,
                index: event.index,
                completed: event.completed,
                changeCompletedStatus: FormzStatus.submissionSuccess,
              ),
            ),
          );
        }
      },
    );
  }
}
