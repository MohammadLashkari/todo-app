import 'package:flutter/material.dart';
import '../providers/providers.dart';
import 'package:provider/provider.dart';

class SearchTodo extends StatelessWidget {
  const SearchTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          labelText: 'Search',
          floatingLabelStyle: const TextStyle(fontSize: 20),
          filled: true,
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: (String? newSearchTerm) {
          if (newSearchTerm != null) {
            context.read<TodoSearch>().setSearchTerm(newSearchTerm);
          }
        },
      ),
    );
  }
}
