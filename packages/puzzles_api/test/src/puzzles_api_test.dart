import 'package:puzzles_api/puzzles_api.dart';
import 'package:test/test.dart';

class TestPuzzlesApi extends PuzzlesApi {
  TestPuzzlesApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('PuzzleStatesApi', () {
    test('can be constructed', () {
      expect(TestPuzzlesApi(), isA<PuzzlesApi>());
      expect(() => TestPuzzlesApi(), returnsNormally);
    });
  });
}
