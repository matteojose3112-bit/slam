import 'package:flutter_test/flutter_test.dart';
import 'package:slam/main.dart';

void main() {
  testWidgets('shows the SLAM foundation experience', (tester) async {
    await tester.pumpWidget(const SlamApp());

    expect(find.text('SLAM'), findsOneWidget);
    expect(find.text('Something useful\nis taking shape.'), findsOneWidget);
    expect(find.text('THE IDEA'), findsOneWidget);
    expect(find.text('THE EXPERIENCE'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('THE PLAN'), 300);
    expect(find.text('THE PLAN'), findsOneWidget);
  });
}
