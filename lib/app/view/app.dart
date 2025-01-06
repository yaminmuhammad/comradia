import 'package:api_repository/api_repository.dart';
import 'package:comradia/app/view/app_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({required this.apiRepository, super.key});

  final ApiRepository apiRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: apiRepository,
      child: const AppView(),
    );
  }
}
