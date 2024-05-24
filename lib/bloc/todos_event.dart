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
