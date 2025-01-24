import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';

sealed class SfxAssets {
  static const String backgroundMusic = 'test.wav';
}

class GameAudioPlayer {

  static void playBackgroundMusic(String asset) {
    final Bgm bgm = FlameAudio.bgm;
    if (bgm.isPlaying) {
      bgm.stop();
    }

    bgm.play(asset, volume: 0.2);
  }

  static void playEffect(String asset) => FlameAudio.play(asset, volume: 0.2);
}
