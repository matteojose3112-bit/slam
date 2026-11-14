import 'package:material_ui/material_ui.dart' show TextField;
import 'package:flutter_test/flutter_test.dart';
import 'package:slam/main.dart';

void main() {
  testWidgets('shows four phone choices and low-volume free default', (tester) async {
    await tester.pumpWidget(const SlamApp());
    expect(find.text('PHONE SLAM'), findsOneWidget);
    expect(find.text('CLASSIC ROTARY'), findsOneWidget);
    expect(find.text('PAY PHONE'), findsOneWidget);
    expect(find.text('90s OFFICE PHONE'), findsOneWidget);
    expect(find.text('CORDLESS PHONE'), findsOneWidget);
    expect(find.textContaining('VOLUME: LOW'), findsOneWidget);
    expect(find.text('OPEN DIALER'), findsOneWidget);
  });

  testWidgets('navigates through dialer into call simulation', (tester) async {
    await tester.pumpWidget(const SlamApp());
    await tester.tap(find.text('OPEN DIALER'));
    await tester.pumpAndSettle();
    expect(find.text('DIALER'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Matteo');
    await tester.pump();
    await tester.tap(find.text('CALL MATTEO'));
    await tester.pumpAndSettle();
    expect(find.text('ACTIVE CALL SIMULATION'), findsOneWidget);
    expect(find.text('Matteo'), findsOneWidget);
    expect(find.text('SLAM!'), findsOneWidget);
  });

  testWidgets('explains that Pro billing is not connected', (tester) async {
    await tester.pumpWidget(const SlamApp());
    await tester.tap(find.text('LOW 🔉'));
    await tester.pumpAndSettle();
    expect(find.text('UNLOCK HIGH VOLUME'), findsOneWidget);
    expect(find.textContaining('In-app purchases are not connected'), findsOneWidget);
  });
}
