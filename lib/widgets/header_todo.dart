import 'package:flutter/material.dart';
import '../providers/providers.dart';
import 'package:provider/provider.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          'To-Do',
          style: TextStyle(
            fontSize: 40,
            color: Colors.deepPurple,
          ),
        ),
        Text(
          '${context.watch<ActiveTodoCountState>().activetodoCount} items left',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
