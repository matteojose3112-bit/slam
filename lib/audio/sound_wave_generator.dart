import 'dart:math';
import 'dart:typed_data';

/// Synthesizes short, original mono PCM WAV effects for the SLAM soundboard.
class SoundWaveGenerator {
  SoundWaveGenerator({Random? random}) : _random = random ?? Random();

  static const int sampleRate = 22050;
  final Random _random;

  /// Returns a complete 16-bit mono WAV file for [effectId].
  Uint8List render(String effectId) {
    final duration = switch (effectId) {
      'mechanical' => 0.2,
      'busy' => 1.4,
      'vinyl' => 0.6,
      'impact' => 0.8,
      _ => 0.7,
    };
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
          break;
        case 'busy':
          final phase = time % 0.8;
          final envelope = phase < 0.38 ? 1.0 : 0.0;
          sample = (sin(2 * pi * 480 * time) + sin(2 * pi * 620 * time)) *
              0.22 *
              envelope;
          break;
        case 'vinyl':
          final progress = (time / duration).clamp(0.0, 1.0);
          final frequency = 760 - (progress * 570);
          final envelope = (1 - progress) * (1 - progress);
          sample = sin(2 * pi * frequency * time) * envelope * 0.72;
          break;
        case 'impact':
          final low = sin(2 * pi * 72 * time) * exp(-time * 7);
          final body = sin(2 * pi * 155 * time) * exp(-time * 13);
          final transient = noise * exp(-time * 48);
          sample = (low * 0.65) + (body * 0.35) + (transient * 0.2);
          break;
        default:
          final firstClack = exp(-time * 58);
          final secondTime = (time - 0.105).clamp(0.0, 1.0);
          final secondClack =
              time >= 0.105 ? exp(-secondTime * 72) : 0.0;
          final body = sin(2 * pi * 138 * time) * exp(-time * 8.5);
          final rattle =
              noise * (firstClack * 0.32 + secondClack * 0.24);
          final resonance =
              sin(2 * pi * 410 * time) * exp(-time * 17) * 0.3;
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
}
