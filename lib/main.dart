import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const SlamApp());
}

class SlamApp extends StatelessWidget {
  const SlamApp({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF101014);
    const accent = Color(0xFFD5FF5F);

    return MaterialApp(
      title: 'SLAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
          surface: const Color(0xFF1A1A20),
        ),
        fontFamily: 'Roboto',
      ),
      home: const SoundboardScreen(),
    );
  }
}

class SoundEffect {
  const SoundEffect({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.icon,
    required this.category,
  });

  final String id;
  final String name;
  final String description;
  final String duration;
  final IconData icon;
  final String category;
}

const soundEffects = <SoundEffect>[
  SoundEffect(
    id: 'handset',
    name: 'The Handset Slam',
    description: 'A chunky, old-school receiver drop.',
    duration: '0.7 sec',
    icon: Icons.phone_in_talk_rounded,
    category: 'THE CLASSIC',
  ),
  SoundEffect(
    id: 'mechanical',
    name: 'Hard Disconnect',
    description: 'A crisp mechanical switch and click.',
    duration: '0.2 sec',
    icon: Icons.power_settings_new_rounded,
    category: 'CLEAN CUT',
  ),
  SoundEffect(
    id: 'busy',
    name: 'The Busy Signal',
    description: 'That unmistakable retro telephone tone.',
    duration: '1.4 sec',
    icon: Icons.phone_missed_rounded,
    category: 'OLD SCHOOL',
  ),
  SoundEffect(
    id: 'vinyl',
    name: 'Record Stop',
    description: 'A dramatic pitch drop to end the scene.',
    duration: '0.6 sec',
    icon: Icons.album_rounded,
    category: 'DRAMATIC',
  ),
  SoundEffect(
    id: 'impact',
    name: 'The Mic Drop',
    description: 'A deep, punchy cinematic impact.',
    duration: '0.8 sec',
    icon: Icons.graphic_eq_rounded,
    category: 'MAKE AN EXIT',
  ),
];

class SoundboardScreen extends StatefulWidget {
  const SoundboardScreen({super.key});

  @override
  State<SoundboardScreen> createState() => _SoundboardScreenState();
}

class _SoundboardScreenState extends State<SoundboardScreen> {
  final Random _random = Random(41);
  AudioPlayer? _player;
  StreamSubscription<void>? _completionSubscription;
  String _selectedId = 'handset';
  bool _isPlaying = false;
  String? _statusMessage;

  SoundEffect get _selectedEffect =>
      soundEffects.firstWhere((effect) => effect.id == _selectedId);

  Future<void> _playSelectedEffect() async {
    final player = _player ??= AudioPlayer();
    _completionSubscription ??= player.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() => _isPlaying = false);
      }
    });

    setState(() {
      _isPlaying = true;
      _statusMessage = null;
    });

    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/slam_${_selectedId}.wav');
      await file.writeAsBytes(_renderWave(_selectedId), flush: true);
      await player.stop();
      await player.play(DeviceFileSource(file.path));
    } catch (_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _statusMessage = 'Could not play this preview. Try again.';
        });
      }
    }
  }

  Uint8List _renderWave(String effectId) {
    const sampleRate = 22050;
    final duration = effectId == 'busy' ? 1.4 : (effectId == 'impact' ? 0.8 : 0.7);
    final sampleCount = (sampleRate * duration).round();
    final dataLength = sampleCount * 2;
    final bytes = ByteData(44 + dataLength);

    void writeText(int offset, String value) {
      for (var index = 0; index < value.length; index++) {
        bytes.setUint8(offset + index, value.codeUnitAt(index));
      }
    }

    writeText(0, 'RIFF');
    bytes.setUint32(4, 36 + dataLength, Endian.little);
    writeText(8, 'WAVE');
    writeText(12, 'fmt ');
    bytes.setUint32(16, 16, Endian.little);
    bytes.setUint16(20, 1, Endian.little);
    bytes.setUint16(22, 1, Endian.little);
    bytes.setUint32(24, sampleRate, Endian.little);
    bytes.setUint32(28, sampleRate * 2, Endian.little);
    bytes.setUint16(32, 2, Endian.little);
    bytes.setUint16(34, 16, Endian.little);
    writeText(36, 'data');
    bytes.setUint32(40, dataLength, Endian.little);

    for (var index = 0; index < sampleCount; index++) {
      final time = index / sampleRate;
      final noise = (_random.nextDouble() * 2) - 1;
      double sample;

      switch (effectId) {
        case 'mechanical':
          final click = exp(-time * 95);
          sample = (sin(2 * pi * 1850 * time) * click * 0.62) +
              (noise * click * 0.28);
        case 'busy':
          final phase = time % 0.8;
          final envelope = phase < 0.38 ? 1.0 : 0.0;
          sample = (sin(2 * pi * 480 * time) +
                  sin(2 * pi * 620 * time)) *
              0.22 *
              envelope;
        case 'vinyl':
          final progress = (time / duration).clamp(0.0, 1.0);
          final frequency = 760 - (progress * 570);
          final envelope = (1 - progress) * (1 - progress);
          sample = sin(2 * pi * frequency * time) * envelope * 0.72;
        case 'impact':
          final low = sin(2 * pi * 72 * time) * exp(-time * 7);
          final body = sin(2 * pi * 155 * time) * exp(-time * 13);
          final transient = noise * exp(-time * 48);
          sample = (low * 0.65) + (body * 0.35) + (transient * 0.2);
        default:
          final firstClack = exp(-time * 58);
          final secondTime = (time - 0.105).clamp(0.0, 1.0);
          final secondClack = time >= 0.105 ? exp(-secondTime * 72) : 0.0;
          final body = sin(2 * pi * 138 * time) * exp(-time * 8.5);
          final rattle = noise * (firstClack * 0.32 + secondClack * 0.24);
          final resonance = sin(2 * pi * 410 * time) * exp(-time * 17) * 0.3;
          sample = (body * 0.62) + rattle + resonance;
      }

      final clipped = sample.clamp(-1.0, 1.0);
      bytes.setInt16(
        44 + (index * 2),
        (clipped * 32767).round(),
        Endian.little,
      );
    }

    return Uint8List.view(bytes.buffer);
  }

  void _selectEffect(String id) {
    setState(() {
      _selectedId = id;
      _statusMessage = null;
    });
  }

  @override
  void dispose() {
    _completionSubscription?.cancel();
    if (_player != null) {
      unawaited(_player!.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFD5FF5F);
    const muted = Color(0xFF9A9AA5);
    final selected = _selectedEffect;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 32),
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Icon(
                        Icons.phone_in_talk_rounded,
                        color: Color(0xFF101014),
                        size: 23,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'SLAM',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF272A20),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFF454B31)),
                      ),
                      child: const Text(
                        'SOUND LAB 01',
                        style: TextStyle(
                          color: accent,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 34),
                const Text(
                  'MAKE YOUR\nEXIT MEMORABLE.',
                  style: TextStyle(
                    fontSize: 35,
                    height: 1.02,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.4,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'The call is over. Make the ending count.',
                  style: TextStyle(color: muted, fontSize: 15, height: 1.4),
                ),
                const SizedBox(height: 26),
                _SelectedSoundCard(
                  effect: selected,
                  isPlaying: _isPlaying,
                  onPlay: _playSelectedEffect,
                ),
                if (_statusMessage != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    _statusMessage!,
                    style: const TextStyle(color: Color(0xFFFF8A80)),
                  ),
                ],
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Text(
                      'PICK YOUR SIGN-OFF',
                      style: TextStyle(
                        color: muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.6,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '5 SOUNDS',
                      style: TextStyle(
                        color: muted,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                for (final effect in soundEffects) ...[
                  _SoundEffectTile(
                    effect: effect,
                    selected: effect.id == _selectedId,
                    onTap: () => _selectEffect(effect.id),
                    onPreview: () {
                      _selectEffect(effect.id);
                      unawaited(_playSelectedEffect());
                    },
                  ),
                  const SizedBox(height: 9),
                ],
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A20),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFF34343D)),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: accent, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'THE NEXT LEVEL',
                              style: TextStyle(
                                color: accent,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.4,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Automatic call-end playback is being explored. '
                              'For now, choose a sound and test it here.',
                              style: TextStyle(
                                color: muted,
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'A LITTLE DRAMA NEVER HURT.',
                    style: TextStyle(
                      color: Color(0xFF696974),
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.7,
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

class _SelectedSoundCard extends StatelessWidget {
  const _SelectedSoundCard({
    required this.effect,
    required this.isPlaying,
    required this.onPlay,
  });

  final SoundEffect effect;
  final bool isPlaying;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFD5FF5F);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF292B21), Color(0xFF1B1C1A)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF4B5136)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.graphic_eq_rounded, color: accent, size: 16),
              SizedBox(width: 7),
              Text(
                'YOUR CURRENT SIGN-OFF',
                style: TextStyle(
                  color: accent,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(
                  effect.icon,
                  color: const Color(0xFF101014),
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      effect.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      effect.description,
                      style: const TextStyle(
                        color: Color(0xFFB0B0B8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onPlay,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: const Color(0xFF101014),
                padding: const EdgeInsets.symmetric(vertical: 17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              icon: Icon(
                isPlaying ? Icons.graphic_eq_rounded : Icons.play_arrow_rounded,
                size: 22,
              ),
              label: Text(
                isPlaying ? 'PLAYING YOUR SIGN-OFF' : 'TEST THIS SOUND',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SoundEffectTile extends StatelessWidget {
  const _SoundEffectTile({
    required this.effect,
    required this.selected,
    required this.onTap,
    required this.onPreview,
  });

  final SoundEffect effect;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFD5FF5F);

    return Material(
      color: selected ? const Color(0xFF25291D) : const Color(0xFF1A1A20),
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: selected ? const Color(0xFF697544) : const Color(0xFF303039),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: selected ? accent : const Color(0xFF2A2A32),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  effect.icon,
                  color: selected ? const Color(0xFF101014) : Colors.white70,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      effect.category,
                      style: const TextStyle(
                        color: Color(0xFF9696A1),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      effect.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      effect.duration,
                      style: const TextStyle(
                        color: Color(0xFF92929D),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onPreview,
                tooltip: 'Preview ${effect.name}',
                icon: Icon(
                  selected ? Icons.play_circle_fill_rounded : Icons.play_circle_outline_rounded,
                  color: selected ? accent : Colors.white70,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
