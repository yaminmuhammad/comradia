// ignore_for_file: prefer_const_constructors

import 'package:env/env.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Env', () {
    test('can be instantiated', () {
      expect(Env(), isNotNull);
    });
  });
}
