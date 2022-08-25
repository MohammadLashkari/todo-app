import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:todo/providers/providers.dart';

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

class FilteredTodo extends StateNotifier<FilteredTodoState> with LocatorMixin {
  FilteredTodo() : super(FilteredTodoState.initial());

  @override
  void update(Locator watch) {
    final Filter filter = watch<TodoFilterState>().filter;
    final String searchTerm = watch<TodoSearchState>().searchTerm;

    final List<Todo> todos = watch<TodoListState>().todos;

    List<Todo> filterTodo;

    switch (filter) {
      case Filter.active:
        filterTodo = todos.where((Todo todo) => !todo.completed).toList();
        break;

      case Filter.completed:
        filterTodo = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
        filterTodo = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      filterTodo = filterTodo
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }

    state = state.copyWith(filteredTodos: filterTodo);
    super.update(watch);
  }
}
