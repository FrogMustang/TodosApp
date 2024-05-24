import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todos.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  final int id;
  final String title;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    this.completed = false,
  });

  factory Todo.fromJSON(json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        completed,
      ];
}
