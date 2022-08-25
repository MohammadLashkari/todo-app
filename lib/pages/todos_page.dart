import 'package:flutter/material.dart';
import 'package:todo/widgets/widgets.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff304352),
                  Color(0xffd7d2cc),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 40.0),
                child: Column(
                  children: [
                    const TodoHeader(),
                    const SizedBox(height: 20.0),
                    const SearchTodo(),
                    const SizedBox(height: 10.0),
                    const FiltersTodo(),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 390,
                      child: ShowTodo(scrollController: scrollController),
                    ),
                    const SizedBox(height: 20),
                    const CreateTodo(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
