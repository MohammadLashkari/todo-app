import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

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

class ActiveTodoCount extends StateNotifier<ActiveTodoCountState>
    with LocatorMixin {
  ActiveTodoCount() : super(ActiveTodoCountState.initial());

  @override
  void update(Locator watch) {
    final List<Todo> todos = watch<TodoListState>().todos;
    state = state.copyWith(
      activetodoCount: todos
          .where((Todo todo) => !todo.completed) // NOT FINISHED YET
          .toList()
          .length,
    );
    super.update(watch);
  }
}
