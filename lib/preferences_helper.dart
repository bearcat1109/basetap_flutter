import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String _keyPrefix = 'player_';
  
  // Save player data
  static Future<void> savePlayerData({
    required int playerIndex,
    required int baseId,
    required int leaderId,
    String? playerName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${_keyPrefix}${playerIndex}_base', baseId);
    await prefs.setInt('${_keyPrefix}${playerIndex}_leader', leaderId);
    if (playerName != null) {
      await prefs.setString('${_keyPrefix}${playerIndex}_name', playerName);
    }
  }
  
  // Load player base
  static Future<int?> getPlayerBase(int playerIndex) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('${_keyPrefix}${playerIndex}_base');
  }
  
  // Load player leader
  static Future<int?> getPlayerLeader(int playerIndex) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('${_keyPrefix}${playerIndex}_leader');
  }
  
  // Load player name
  static Future<String?> getPlayerName(int playerIndex) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('${_keyPrefix}${playerIndex}_name');
  }
}