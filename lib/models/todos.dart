import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todos.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  final int id;
  final String title;
  final bool completed;
  final FormzStatus changeCompletedStatus;

  const Todo({
    required this.id,
    required this.title,
    this.completed = false,
    this.changeCompletedStatus = FormzStatus.pure,
  });

  factory Todo.fromJSON(json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Todo copyWith({
    int? id,
    String? title,
    bool? completed,
    FormzStatus? changeCompletedStatus,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      changeCompletedStatus:
          changeCompletedStatus ?? this.changeCompletedStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        completed,
        changeCompletedStatus,
      ];
}
