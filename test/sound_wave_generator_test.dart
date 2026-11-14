import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:slam/audio/sound_wave_generator.dart';

void main() {
  group('SoundWaveGenerator', () {
    test('writes a valid mono PCM WAV header', () {
      final wave = SoundWaveGenerator().render('handset');
      final header = ByteData.sublistView(wave);

      expect(String.fromCharCodes(wave.sublist(0, 4)), 'RIFF');
      expect(String.fromCharCodes(wave.sublist(8, 12)), 'WAVE');
      expect(String.fromCharCodes(wave.sublist(12, 16)), 'fmt ');
      expect(String.fromCharCodes(wave.sublist(36, 40)), 'data');
      expect(header.getUint16(20, Endian.little), 1);
      expect(header.getUint16(22, Endian.little), 1);
      expect(header.getUint32(24, Endian.little), 22050);
      expect(header.getUint16(34, Endian.little), 16);
      expect(header.getUint32(40, Endian.little), wave.length - 44);
      expect(header.getUint32(4, Endian.little), wave.length - 8);
    });

    test('uses the advertised duration for each built-in effect', () {
      final generator = SoundWaveGenerator();
      final expectedLengths = <String, int>{
        'handset': 30914,
        'mechanical': 8864,
        'busy': 61784,
        'vinyl': 26504,
        'impact': 35324,
      };

      for (final entry in expectedLengths.entries) {
        expect(
          generator.render(entry.key).length,
          entry.value,
          reason: '${entry.key} should render at its preset duration',
        );
      }
    });
  });
}
