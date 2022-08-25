import 'package:flutter/material.dart';
import '../providers/providers.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';

class FiltersTodo extends StatelessWidget {
  const FiltersTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildFilterButton(context, Filter.all),
        buildFilterButton(context, Filter.active),
        buildFilterButton(context, Filter.completed),
      ],
    );
  }

  Widget buildFilterButton(BuildContext context, Filter filter) {
    return TextButton(
      onPressed: () {
        context.read<TodoFilter>().changeFilter(filter);
      },
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.active
                ? 'Active'
                : 'Complete',
        style: TextStyle(
          fontSize: 18.0,
          color: buttonColor(context, filter),
        ),
      ),
    );
  }

  Color? buttonColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterState>().filter;
    return currentFilter == filter ? Colors.deepPurple : Colors.black38;
  }
}
