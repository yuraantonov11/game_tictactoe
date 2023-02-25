import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  bool _soundEnabled = true;
  final AudioPlayer _audioPlayer = AudioPlayer();
  // Add the getter for the soundEnabled property
  bool get soundEnabled => _soundEnabled;

  SoundManager() {
    readSoundEnabledState();
  }


  // Read the value of the soundEnabled property from shared preferences
  Future<void> readSoundEnabledState() async {
    final prefs = await SharedPreferences.getInstance();
    _soundEnabled = prefs.getBool('soundEnabled') ?? true;
  }

  // Save the value of the soundEnabled property to shared preferences
  Future<void> saveSoundEnabledState(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', isEnabled);
    _soundEnabled = isEnabled;
  }

  // Update the playSound method to check if sound is enabled
  Future<void> playSound(String soundPath) async {
    if (_soundEnabled) {
      await _audioPlayer.play(AssetSource(soundPath));
    }
  }

  // Add the toggleSound method
  void toggleSound() async {
    _soundEnabled = !_soundEnabled;
    await saveSoundEnabledState(_soundEnabled);
  }
}
