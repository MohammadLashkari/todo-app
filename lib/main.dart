import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/providers.dart';
import 'pages/todos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'To-Do App';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ProxyProvider<TodoList, ActiveTodoCount>(
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodoCount? activeTodoCount,
          ) =>
              ActiveTodoCount(
            todoList: todoList,
          ),
        ),
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodo>(
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodo? filteredTodo,
          ) =>
              FilteredTodo(
            todoFilter: todoFilter,
            todoList: todoList,
            todoSearch: todoSearch,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(Colors.deepPurple),
            crossAxisMargin: 2,
          ),
        ),
        home: const TodoPage(),
      ),
    );
  }
}
