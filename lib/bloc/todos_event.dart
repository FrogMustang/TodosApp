part of 'todos_bloc.dart';

sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

class AllTodosFetched extends TodosEvent {
  const AllTodosFetched();

  @override
  List<Object?> get props => [];
}

class TodoCreated extends TodosEvent {
  const TodoCreated({required this.todo});

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

class TodoCompletedChanged extends TodosEvent {
  const TodoCompletedChanged({
    required this.index,
    required this.completed,
  });

  /// Index inside the list of TODOs. Used to update the state
  final int index;
  final bool completed;

  @override
  List<Object?> get props => [
        index,
        completed,
      ];
}
