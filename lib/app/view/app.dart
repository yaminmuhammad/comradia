import 'package:api_repository/api_repository.dart';
import 'package:comradia/app/app.dart';
import 'package:comradia/todos/cubit/todos_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({required this.apiRepository, super.key});

  final ApiRepository apiRepository;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosCubit(
        apiRepository: apiRepository,
      ),
      child: const AppView(),
    );
  }
}
