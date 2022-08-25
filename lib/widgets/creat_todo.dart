import 'package:flutter/material.dart';
import '../providers/providers.dart';
import 'package:provider/provider.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20.0,
      child: TextField(
        controller: newTodoController,
        decoration: InputDecoration(
          labelText: 'Add a new todo item',
          filled: true,
          fillColor: Colors.grey[300],
          floatingLabelStyle: const TextStyle(fontSize: 17),
          suffixIcon: Icon(
            Icons.note_add_rounded,
            size: 35,
            color: Colors.deepPurple[400],
          ),
        ),
        onSubmitted: (String? todoDesc) {
          if (todoDesc != null && todoDesc.trim().isNotEmpty) {
            context.read<TodoList>().addTodo(todoDesc);
            newTodoController.clear();
          }
        },
      ),
    );
  }
}
