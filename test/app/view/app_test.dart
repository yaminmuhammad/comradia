import 'package:api_repository/api_repository.dart';
import 'package:comradia/app/view/app.dart';
import 'package:comradia/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      const apiRepository = ApiRepository();
      await tester.pumpWidget(
        const App(
          apiRepository: apiRepository,
        ),
      );
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
