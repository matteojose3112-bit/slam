import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SlamApp());
}

class SlamApp extends StatelessWidget {
  const SlamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PHONE SLAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E2022),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE63946),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SlamHome(),
    );
  }
}

enum SlamScreen { home, dialer, call }

class SlamSound {
  const SlamSound({
    required this.id,
    required this.title,
    required this.description,
    required this.assetKey,
    this.offset = Duration.zero,
    this.clipDuration,
  });

  final String id;
  final String title;
  final String description;
  final String assetKey;
  final Duration offset;
  final Duration? clipDuration;
}

const slamSounds = <SlamSound>[
  SlamSound(
    id: 'rotary',
    title: 'CLASSIC ROTARY',
    description: 'Heavy mechanical CLACK-RINGGG. Pure old-school authority.',
    assetKey: 'rotary',
    offset: Duration(seconds: 3),
  ),
  SlamSound(
    id: 'payphone',
    title: 'PAY PHONE',
    description: 'A hollow metallic CLANK with a coin-return finish.',
    assetKey: 'payphone',
  ),
  SlamSound(
    id: 'office',
    title: '90s OFFICE PHONE',
    description: 'An aggressive plastic THUD that shakes the desk.',
    assetKey: 'multi',
    offset: Duration(seconds: 22),
    clipDuration: Duration(milliseconds: 2500),
  ),
  SlamSound(
    id: 'cordless',
    title: 'CORDLESS PHONE',
    description: 'A sharp, passive-aggressive SNAP.',
    assetKey: 'multi',
    offset: Duration(seconds: 7),
    clipDuration: Duration(seconds: 2),
  ),
];

/// Remote recordings supplied in the stakeholder's original prototype.
/// If an asset URL changes, update it here rather than in the screen code.
const slamAudioUrls = <String, String>{
  'rotary':
      'https://media.base44.com/files/public/6a35ec5a4d83cfc878f56075/93ef3b8c9218083_phone-pick-up-hang-up.wav',
  'payphone':
      'https://media.base44.com/files/public/6a35ec5a4d83cfc878f56075/f9d85eb04832762_rds__phone-handset-slam.wav',
  'multi':
      'https://media.base44.com/files/public/6a35ec5a4d83cfc878f56075/56d44105c450805_kyles_phone-receiver-put-down-hang-up-various-slam-close-and-roomy.wav',
};

class SlamHome extends StatefulWidget {
  const SlamHome({super.key});

  @override
  State<SlamHome> createState() => _SlamHomeState();
}

class _SlamHomeState extends State<SlamHome> {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<void>? _completionSubscription;
  Timer? _clipTimer;

  SlamScreen _screen = SlamScreen.home;
  String _selectedPhone = 'rotary';
  String _contactName = 'Boss';
  final TextEditingController _nameController =
      TextEditingController(text: 'Boss');
  bool _isHighVolume = false;
  bool _isPro = false;
  bool _isPlaying = false;
  String? _audioError;

  SlamSound get _selectedSound =>
      slamSounds.firstWhere((sound) => sound.id == _selectedPhone);

  @override
  void initState() {
    super.initState();
    _completionSubscription = _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  Future<void> _playSlam() async {
    final sound = _selectedSound;
    final url = slamAudioUrls[sound.assetKey];
    if (url == null) return;

    _clipTimer?.cancel();
    setState(() {
      _isPlaying = true;
      _audioError = null;
    });

    try {
      await _player.stop();
      await _player.play(
        UrlSource(url),
        position: sound.offset,
        volume: _isHighVolume && _isPro ? 1.0 : 0.42,
      );
      if (sound.clipDuration != null) {
        _clipTimer = Timer(sound.clipDuration!, () async {
          await _player.stop();
          if (mounted) setState(() => _isPlaying = false);
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _audioError =
              'Could not load this recording. Check the connection and try again.';
        });
      }
    }
  }

  void _choosePhone(String id) {
    setState(() {
      _selectedPhone = id;
      _audioError = null;
    });
  }

  void _toggleVolume() {
    if (!_isHighVolume && !_isPro) {
      showDialog<void>(context: context, builder: (dialogContext) => AlertDialog(title: const Text('UNLOCK HIGH VOLUME'), content: const Text('High-volume mode is reserved for SLAM PRO. In-app purchases are not connected in this prototype yet.'), actions: [TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('GOT IT'))]));
      return;
    }
    setState(() => _isHighVolume = !_isHighVolume);
  }

  void _openCallSimulation() {
    _contactName = _nameController.text.trim().isEmpty
        ? 'Someone'
        : _nameController.text.trim();
    setState(() => _screen = SlamScreen.call);
  }

  Future<void> _handleSlamButton() async {
    await _playSlam();
    if (!mounted) return;
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (mounted) setState(() => _screen = SlamScreen.home);
  }

  @override
  void dispose() {
    _clipTimer?.cancel();
    _completionSubscription?.cancel();
    _nameController.dispose();
    unawaited(_player.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: switch (_screen) {
                SlamScreen.home => _buildHome(),
                SlamScreen.dialer => _buildDialer(),
                SlamScreen.call => _buildCall(),
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHome() {
    return Padding(
      key: const ValueKey('home'),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'PHONE SLAM',
                  style: TextStyle(
                    color: Color(0xFFE63946),
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
              _tierPill(),
            ],
          ),
          const SizedBox(height: 5),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Choose your weapon. End the call right.',
              style: TextStyle(color: Color(0xFFA8DADC), fontSize: 13),
            ),
          ),
          const SizedBox(height: 22),
          Expanded(
            child: ListView(
              children: [
                for (final sound in slamSounds) ...[
                  _phoneCard(sound),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
          if (_audioError != null) ...[
            const SizedBox(height: 8),
            Text(
              _audioError!,
              style: const TextStyle(color: Color(0xFFFF8A80), fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2E33),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'VOLUME: ${_isHighVolume ? 'HIGH' : 'LOW'}${_isPro ? '' : '  ·  HIGH IS PRO'}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _toggleVolume,
                  child: Text(_isHighVolume ? 'HIGH 🔊' : 'LOW 🔉'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFE63946),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () => setState(() => _screen = SlamScreen.dialer),
              child: const Text(
                'OPEN DIALER',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(height: 9),
          const Text(
            'CALL SIMULATION ONLY · NO PHONE CALL IS PLACED',
            style: TextStyle(
              color: Color(0xFF888888),
              fontSize: 9,
              letterSpacing: 0.7,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _tierPill() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _isPro ? const Color(0xFF2A9D8F) : const Color(0xFFF4A261),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Text(
          _isPro ? 'PRO PREVIEW' : 'FREE TIER',
          style: const TextStyle(
            color: Color(0xFF1E2022),
            fontSize: 9,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _phoneCard(SlamSound sound) {
    final selected = sound.id == _selectedPhone;
    return Material(
      color: selected ? const Color(0xFF2A2E33) : const Color(0xFF222528),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _choosePhone(sound.id),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: selected
                  ? const Color(0xFFA8DADC)
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sound.title,
                      style: const TextStyle(
                        color: Color(0xFFF1FAEE),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      sound.description,
                      style: const TextStyle(
                        color: Color(0xFFB0B5BC),
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Preview ${sound.title}',
                onPressed: () {
                  _choosePhone(sound.id);
                  unawaited(_playSlam());
                },
                icon: Icon(
                  Icons.play_circle_fill_rounded,
                  color: selected ? const Color(0xFFA8DADC) : Colors.white70,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialer() {
    return Padding(
      key: const ValueKey('dialer'),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => setState(() => _screen = SlamScreen.home),
              icon: const Icon(Icons.arrow_back),
              label: const Text('BACK'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DIALER',
            style: TextStyle(
              color: Color(0xFFE63946),
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Using: ${_selectedSound.title}',
            style: const TextStyle(color: Color(0xFFA8DADC), fontSize: 11),
          ),
          const SizedBox(height: 28),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Who's getting slammed?",
              filled: true,
              fillColor: const Color(0xFF2A2E33),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => setState(() => _contactName = value),
          ),
          const Spacer(),
          const Icon(
            Icons.phone_in_talk_rounded,
            color: Color(0xFFA8DADC),
            size: 65,
          ),
          const SizedBox(height: 16),
          Text(
            'Ready to call ${_nameController.text.trim().isEmpty ? 'Someone' : _nameController.text.trim()}.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF888888)),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2A9D8F),
                padding: const EdgeInsets.symmetric(vertical: 17),
              ),
              onPressed: _openCallSimulation,
              child: Text('CALL ${_nameController.text.trim().isEmpty ? 'CONTACT' : _nameController.text.trim().toUpperCase()}'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCall() {
    return Padding(
      key: const ValueKey('call'),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ACTIVE CALL SIMULATION',
            style: TextStyle(
              color: Color(0xFFA8DADC),
              fontSize: 11,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _contactName,
            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          const Text(
            '● LIVE',
            style: TextStyle(
              color: Color(0xFFE63946),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 54),
          SizedBox(
            width: 190,
            height: 190,
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: const CircleBorder(
                  side: BorderSide(color: Color(0xFFF1FAEE), width: 8),
                ),
                backgroundColor: const Color(0xFFE63946),
                foregroundColor: Colors.white,
                elevation: 12,
              ),
              onPressed: _isPlaying ? null : _handleSlamButton,
              child: const Text(
                'SLAM!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(height: 42),
          const Text(
            'Hang up with authority.',
            style: TextStyle(color: Color(0xFF888888), fontSize: 12),
          ),
          if (_audioError != null) ...[
            const SizedBox(height: 14),
            Text(
              _audioError!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFFFF8A80), fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
