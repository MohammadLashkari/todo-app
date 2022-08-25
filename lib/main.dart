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
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(),
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodoCount? activeTodoCount,
          ) =>
              activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
            FilteredTodo>(
          create: (context) => FilteredTodo(),
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodo? filteredTodo,
          ) =>
              filteredTodo!..update(todoFilter, todoSearch, todoList),
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
