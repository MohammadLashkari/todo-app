import 'package:flutter/material.dart';
import '../providers/providers.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';

class ShowTodo extends StatelessWidget {
  const ShowTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodo>().state.filteredTodos;

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          background: swipeAction(0),
          secondaryBackground: swipeAction(1),
          onDismissed: (_) {
            context.read<TodoList>().removeTodo(todos[index].id);
          },
          confirmDismiss: (_) {
            return deleteConfirmDialog(context);
          },
          child: TodoItem(
            todo: todos[index],
          ),
        );
      },
    );
  }

  Widget swipeAction(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete_forever,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  Future<bool?> deleteConfirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure ?'),
          content: const Text('Do you really want to delete ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoList>().toggleTodo(widget.todo.id);
        },
      ),
      onTap: () {
        editTodo(context);
      },
      title: Text(widget.todo.desc),
    );
  }

  Future<dynamic> editTodo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        bool error = false;
        textController.text = widget.todo.desc;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Edit Todo'),
              content: TextField(
                controller: textController,
                autofocus: true,
                decoration: InputDecoration(
                  errorText: error ? 'Value cannot be empty' : null,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        error = textController.text.isEmpty ? true : false;
                        if (!error) {
                          context.read<TodoList>().editTodo(
                                widget.todo.id,
                                textController.text,
                              );
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                  child: const Text('EDIT'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
