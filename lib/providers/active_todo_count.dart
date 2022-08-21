import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class ActiveTodoCount extends ChangeNotifier {
  ActiveTodoCountState _state = ActiveTodoCountState.initial();

  ActiveTodoCountState get state => _state;

  void update(TodoList todoList) {
    final int newActiveTodoCount = todoList.state.todos
        .where((Todo todo) => !todo.completed) // Not Finished Yet
        .toList()
        .length;

    _state = _state.copyWith(activetodoCount: newActiveTodoCount);
    notifyListeners();
  }
}
