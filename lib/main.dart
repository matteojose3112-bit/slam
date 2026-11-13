import 'package:flutter/material.dart';

void main() {
  runApp(const SlamApp());
}

class SlamApp extends StatelessWidget {
  const SlamApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF635BFF);

    return MaterialApp(
      title: 'SLAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F7FB),
        fontFamily: 'Roboto',
      ),
      home: const FoundationScreen(),
    );
  }
}

class FoundationScreen extends StatelessWidget {
  const FoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'SLAM',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.2,
                          ),
                    ),
                    const Spacer(),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        child: Text(
                          'IN THE MAKING',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: colors.onPrimaryContainer,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.7,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                Text(
                  'Something useful\nis taking shape.',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.08,
                        letterSpacing: -1.1,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'A new mobile experience, designed around the things '
                  'that matter most. We are starting with the idea, '
                  'listening carefully, and building it right.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.55,
                      ),
                ),
                const SizedBox(height: 32),
                _FoundationCard(
                  icon: Icons.lightbulb_outline_rounded,
                  eyebrow: 'THE IDEA',
                  title: 'Start with what matters.',
                  description:
                      'Understand the real need before deciding what to build.',
                ),
                const SizedBox(height: 12),
                _FoundationCard(
                  icon: Icons.design_services_outlined,
                  eyebrow: 'THE EXPERIENCE',
                  title: 'Simple. Thoughtful. Mobile-first.',
                  description:
                      'Make every screen feel clear, useful, and easy to use.',
                ),
                const SizedBox(height: 12),
                _FoundationCard(
                  icon: Icons.rocket_launch_outlined,
                  eyebrow: 'THE PLAN',
                  title: 'Build it step by step.',
                  description:
                      'One shared foundation for Android and iPhone.',
                ),
                const SizedBox(height: 36),
                Center(
                  child: Text(
                    'BUILT WITH FLUTTER  •  POWERED BY A GOOD IDEA',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.outline,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FoundationCard extends StatelessWidget {
  const _FoundationCard({
    required this.icon,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String eyebrow;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.55)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colors.primaryContainer.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: colors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eyebrow,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
