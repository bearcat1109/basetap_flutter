import 'package:flutter/material.dart';
import 'dart:async';
import 'dialogs.dart';

// Welcome screen
class WelcomeScreen extends StatefulWidget {
  final Function(int) onPlayerCountSelected;

  // Add key parameter for AnimatedSwitcher
  const WelcomeScreen({super.key, required this.onPlayerCountSelected});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String currentWelcomeText = "Welcome to BaseTap!";

  // Welcome messages in different languages
  final welcomeTranslations = [
    "Welcome to BaseTap!",
    "ようこそ",
    "ᎣᏏᏲ!",
    "¡Bienvenido!"
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Cycle through welcome messages
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        final currentIndex = welcomeTranslations.indexOf(currentWelcomeText);
        final nextIndex = (currentIndex + 1) % welcomeTranslations.length;
        currentWelcomeText = welcomeTranslations[nextIndex];
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Background hyperspace gif
          Image.asset(
            'assets/hyperspacegif.webp',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            gaplessPlayback: true,
          ),
          // Scrollable content to prevent overflow
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.8,
                    maxWidth: 400,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      // App Title
                      Text(
                        currentWelcomeText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.grey, blurRadius: 12.0),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // Subtitle
                      const Text(
                        "We hope you enjoy your stay.\nLegends of the Force Leaders now available.\nMay the Force be with you!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 64),
                      // Player Count Selection
                      const Text(
                        "Select Number of Players",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      // Player Count Buttons - Circular layout in pairs
                      Column(
                        children: [
                          // First row: 1 and 2 players
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCircularPlayerButton(1),
                              _buildCircularPlayerButton(2),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Second row: 3 and 4 players
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCircularPlayerButton(3),
                              _buildCircularPlayerButton(4),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Third row: 5 and 6 players
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCircularPlayerButton(5),
                              _buildCircularPlayerButton(6),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Bottom buttons row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Statistics button (if you have one)
                          TextButton(
                            onPressed: () {
                              // Add statistics functionality here if needed
                            },
                            child: const Text(
                              "Statistics",
                              style: TextStyle(
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                          // Info Button
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => InfoDialog(
                                  onDismissRequest: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              "About BaseTap",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularPlayerButton(int playerCount) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () => widget.onPlayerCountSelected(playerCount),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(0.5),
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          "$playerCount",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
