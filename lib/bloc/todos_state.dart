part of 'todos_bloc.dart';

class TodosState extends Equatable {
  const TodosState({
    this.status = FormzStatus.pure,
    this.todos = const [],
  });

  /// Status of fetching the todos
  final FormzStatus status;

  /// List of all fetched todos
  final List<Todo> todos;

  TodosState copyWith({
    FormzStatus? status,
    List<Todo>? todos,
  }) {
    return TodosState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object?> get props => [
        status,
        todos,
      ];
}
