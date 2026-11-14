import 'package:flutter_test/flutter_test.dart';
import 'package:slam/main.dart';

void main() {
  testWidgets('shows the SLAM soundboard and its default retro sign-off', (
    tester,
  ) async {
    await tester.pumpWidget(const SlamApp());

    expect(find.text('SLAM'), findsOneWidget);
    expect(find.text('MAKE YOUR\nEXIT MEMORABLE.'), findsOneWidget);
    expect(find.text('The Handset Slam'), findsOneWidget);
    expect(find.text('TEST THIS SOUND'), findsOneWidget);
    expect(find.text('PICK YOUR SIGN-OFF'), findsOneWidget);
  });

  testWidgets('lets the user select another sign-off', (tester) async {
    await tester.pumpWidget(const SlamApp());

    await tester.ensureVisible(find.text('Hard Disconnect'));
    await tester.tap(find.text('Hard Disconnect'));
    await tester.pump();

    expect(find.text('Hard Disconnect'), findsOneWidget);
    expect(find.text('TEST THIS SOUND'), findsOneWidget);
  });

  testWidgets('explains that automatic call-end playback is still being explored', (
    tester,
  ) async {
    await tester.pumpWidget(const SlamApp());

    await tester.ensureVisible(find.text('THE NEXT LEVEL'));
    expect(find.text('THE NEXT LEVEL'), findsOneWidget);
    expect(
      find.textContaining('Automatic call-end playback is being explored.'),
      findsOneWidget,
    );
  });
}
