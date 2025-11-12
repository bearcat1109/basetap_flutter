import 'package:shared_preferences/shared_preferences.dart';

// Statistics Manager for tracking player wins
class StatisticsManager {
  static const String _winsPrefix = 'player_wins_';
  static const String _gamesPlayedKey = 'total_games_played';

  // Get total wins for a player (by name)
  static Future<int> getPlayerWins(String playerName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_winsPrefix$playerName') ?? 0;
  }

  // Increment wins for a player
  static Future<void> incrementPlayerWins(String playerName) async {
    final prefs = await SharedPreferences.getInstance();
    final currentWins = await getPlayerWins(playerName);
    await prefs.setInt('$_winsPrefix$playerName', currentWins + 1);
  }

  // Get total games played
  static Future<int> getTotalGamesPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_gamesPlayedKey) ?? 0;
  }

  // Increment total games played
  static Future<void> incrementGamesPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    final currentGames = await getTotalGamesPlayed();
    await prefs.setInt(_gamesPlayedKey, currentGames + 1);
  }

  // Get all player statistics
  static Future<Map<String, int>> getAllPlayerStats() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, int> stats = {};

    for (String key in prefs.getKeys()) {
      if (key.startsWith(_winsPrefix)) {
        final playerName = key.substring(_winsPrefix.length);
        stats[playerName] = prefs.getInt(key) ?? 0;
      }
    }

    return stats;
  }

  // Get win percentage for a player
  static Future<double> getPlayerWinPercentage(String playerName) async {
    final wins = await getPlayerWins(playerName);
    final totalGames = await getTotalGamesPlayed();

    if (totalGames == 0) return 0.0;
    return (wins / totalGames) * 100;
  }

  // Reset all statistics
  static Future<void> resetAllStats() async {
    final prefs = await SharedPreferences.getInstance();
    final keysToRemove = prefs.getKeys()
        .where((key) => key.startsWith(_winsPrefix) || key == _gamesPlayedKey)
        .toList();

    for (String key in keysToRemove) {
      await prefs.remove(key);
    }
  }
}