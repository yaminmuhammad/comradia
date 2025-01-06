import 'package:api_repository/api_repository.dart';
import 'package:comradia/todos/cubit/todos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosCubit(
        apiRepository: context.read<ApiRepository>(),
      ),
      child: const TodosView(),
    );
  }
}

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  @override
  void initState() {
    super.initState();
    context.read<TodosCubit>().fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.select((TodosCubit cubit) => cubit.state);
    return BlocProvider(
      create: (context) =>
          TodosCubit(apiRepository: context.read<ApiRepository>()),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Text(
                    todo,
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
