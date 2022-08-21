import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'todo_list.dart';
import 'todo_search.dart';
import 'todo_filter.dart';
import '../models/todo_model.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> filteredTodos;
  const FilteredTodoState({
    required this.filteredTodos,
  });

  factory FilteredTodoState.initial() {
    return const FilteredTodoState(filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilteredTodoState copyWith({List<Todo>? filteredTodos}) {
    return FilteredTodoState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodo extends ChangeNotifier {
  FilteredTodoState _state = FilteredTodoState.initial();

  FilteredTodoState get state => _state;

  void update(
    TodoFilter todoFilter,
    TodoSearch todoSearch,
    TodoList todoList,
  ) {
    List<Todo> filterTodo;

    switch (todoFilter.state.filter) {
      case Filter.active:
        filterTodo =
            todoList.state.todos.where((Todo todo) => !todo.completed).toList();
        break;

      case Filter.completed:
        filterTodo =
            todoList.state.todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
        filterTodo = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      filterTodo = filterTodo
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearch.state.searchTerm))
          .toList();
    }

    _state = _state.copyWith(filteredTodos: filterTodo);
    notifyListeners();
  }
}
