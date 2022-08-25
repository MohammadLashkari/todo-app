import 'package:equatable/equatable.dart';

import 'package:todo/providers/todo_list.dart';
import '../models/todo_model.dart';

class ActiveTodoCountState extends Equatable {
  final int activetodoCount;

  const ActiveTodoCountState({
    required this.activetodoCount,
  });

  factory ActiveTodoCountState.initial() {
    return const ActiveTodoCountState(activetodoCount: 0);
  }

  @override
  List<Object> get props => [activetodoCount];

  @override
  bool get stringify => true;

  ActiveTodoCountState copyWith({int? activetodoCount}) {
    return ActiveTodoCountState(
      activetodoCount: activetodoCount ?? this.activetodoCount,
    );
  }
}

class ActiveTodoCount {
  final TodoList todoList;
  ActiveTodoCount({
    required this.todoList,
  });

  ActiveTodoCountState get state => ActiveTodoCountState(
        activetodoCount: todoList.state.todos
            .where((Todo todo) => !todo.completed) // NOT FINISHED YET
            .toList()
            .length,
      );
}
