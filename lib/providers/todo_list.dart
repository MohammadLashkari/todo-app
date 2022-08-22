import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  const TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(
      todos: [
        Todo(id: '1', desc: 'Clean the room'),
        Todo(id: '2', desc: 'Wash the dish'),
        Todo(id: '3', desc: 'Do homework'),
      ],
    );
  }

  @override
  List<Object> get props => [todos];

  @override
  bool get stringify => true;

  TodoListState copyWith({List<Todo>? todos}) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.initial();

  TodoListState get state => _state;

  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodos = [..._state.todos, newTodo];

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void editTodo(String id, String newTodoDesc) {
    final newTodos = _state.todos.map(
      (Todo todo) {
        if (todo.id == id) {
          return Todo(id: id, desc: newTodoDesc, completed: todo.completed);
        }
        return todo;
      },
    ).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final newTodos = _state.todos.map(
      (Todo todo) {
        if (todo.id == id) {
          return Todo(id: id, desc: todo.desc, completed: !todo.completed);
        }
        return todo;
      },
    ).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(String id) {
    final newTodos = _state.todos.where((Todo todo) => todo.id != id).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}
