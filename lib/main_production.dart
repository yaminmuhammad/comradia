import 'package:api_repository/api_repository.dart';
import 'package:comradia/app/view/app.dart';
import 'package:comradia/bootstrap.dart';

void main() {
  const apiRepository = ApiRepository();
  bootstrap(() => const App(apiRepository: apiRepository));
}
