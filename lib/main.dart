import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'player_layouts.dart';
import 'dialogs.dart';

void main() {
  runApp(const BaseTapApp());
}

class BaseTapApp extends StatelessWidget {
  const BaseTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BaseTap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// Main screen with game state management
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? initiativePlayer;
  bool showFirstTimePopup = true;
  GameScreen currentScreen = GameScreen.welcome;
  int selectedPlayerCount = 2;

  @override
  void initState() {
    super.initState();
    // In a real app, we would check shared preferences here
    // For now we'll just show the popup on first run
    showFirstTimePopup = true;
  }

  void _onPlayerCountSelected(int count) {
    setState(() {
      selectedPlayerCount = count;
      currentScreen = GameScreen.playerLayout;
    });
  }

  void _onReturnToWelcome() {
    setState(() {
      currentScreen = GameScreen.welcome;
    });
  }

  void _onInitiativeClaimed(int playerId) {
    setState(() {
      initiativePlayer = playerId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content with animation
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              // Determine transition direction based on the screen we're moving to
              final bool isGoingToPlayerLayout = child is! WelcomeScreen;

              final beginOffset = isGoingToPlayerLayout
                  ? const Offset(1.0, 0.0) // From right
                  : const Offset(-1.0, 0.0); // From left

              return SlideTransition(
                position: Tween<Offset>(
                  begin: beginOffset,
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: _buildMainContent(),
          ),

          // First time welcome dialog
          if (showFirstTimePopup)
            GestureDetector(
              onTap: () {}, // Prevent taps from passing through
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: FirstTimeWelcomeDialog(
                    onDismiss: () {
                      setState(() {
                        showFirstTimePopup = false;
                      });
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    // Add a key to help AnimatedSwitcher recognize different widgets
    final Widget content = currentScreen == GameScreen.welcome
        ? WelcomeScreen(
            key: const ValueKey('welcome'),
            onPlayerCountSelected: _onPlayerCountSelected,
          )
        : _buildPlayerLayout();

    return content;
  }

  Widget _buildPlayerLayout() {
    // Add keys to distinguish different player layouts
    switch (selectedPlayerCount) {
      case 1:
        return OnePlayerLayout(
          key: const ValueKey('1player'),
          initiativePlayer: initiativePlayer,
          onInitiativeClaimed: _onInitiativeClaimed,
          onShowPlayerCount: _onReturnToWelcome,
        );
      case 2:
        return TwoPlayerLayout(
          key: const ValueKey('2players'),
          initiativePlayer: initiativePlayer,
          onInitiativeClaimed: _onInitiativeClaimed,
          onShowPlayerCount: _onReturnToWelcome,
        );
      case 3:
        return ThreePlayerLayout(
          key: const ValueKey('3players'),
          initiativePlayer: initiativePlayer,
          onInitiativeClaimed: _onInitiativeClaimed,
          onShowPlayerCount: _onReturnToWelcome,
        );
      case 4:
        return FourPlayerLayout(
          key: const ValueKey('4players'),
          initiativePlayer: initiativePlayer,
          onInitiativeClaimed: _onInitiativeClaimed,
          onShowPlayerCount: _onReturnToWelcome,
        );
      case 5:
        return FivePlayerLayout(
          key: const ValueKey('5players'),
          initiativePlayer: initiativePlayer,
          onInitiativeClaimed: _onInitiativeClaimed,
          onShowPlayerCount: _onReturnToWelcome,
        );
      case 6:
        return SixPlayerLayout(
          key: const ValueKey('6players'),
          initiativePlayer: initiativePlayer,
          onInitiativeClaimed: _onInitiativeClaimed,
          onShowPlayerCount: _onReturnToWelcome,
        );
      default:
        return TwoPlayerLayout(
          key: const ValueKey('default_2players'),
          initiativePlayer: initiativePlayer,
          onInitiativeClaimed: _onInitiativeClaimed,
          onShowPlayerCount: _onReturnToWelcome,
        );
    }
  }
}

// Game screen state enum
enum GameScreen {
  welcome,
  playerLayout,
}
