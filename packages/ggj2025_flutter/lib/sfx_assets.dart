import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';

sealed class SfxAssets {
  static const String backgroundMusic = 'bgm.wav';
  static const String bongo1 = 'bongo3.wav';
  static const String bongo2 = 'bongo4.wav';
  static const String bongo3 = 'bongo1.wav';
  static const String bongo4 = 'bongo2.wav';
  static const String fail1 = 'fail1.wav';
  static const String fail2 = 'fail2.wav';
  static const String chop = 'chop1.wav';
  static const String bounce1 = 'Bounce_Back_1.wav';
  static const String bounce2 = 'Bounce_Back_2.wav';
  static const String bounce3 = 'Bounce_Back_3.wav';
  static const String metro = 'metronome.mp3';
}

class GameAudioPlayer {
  static void playBackgroundMusic(String asset) {
    final Bgm bgm = FlameAudio.bgm;
    if (bgm.isPlaying) {
      bgm.stop();
    }

    bgm.play(asset, volume: 0.05);
  }

  static void playEffect(String asset, [double? volume]) => FlameAudio.play(asset, volume: volume ?? 0.2);
}
