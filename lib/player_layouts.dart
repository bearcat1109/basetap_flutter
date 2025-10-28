import 'dart:async';

import 'package:flutter/material.dart';
import 'player_counter.dart';
import 'dialogs.dart';

// Common control button builder
Widget buildControlButton({
  required IconData icon,
  required VoidCallback onTap,
  Color? color,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        icon,
        color: color ?? Colors.white,
        size: 24,
      ),
    ),
  );
}

// One Player Layout
class OnePlayerLayout extends StatefulWidget {
  final int? initiativePlayer;
  final Function(int) onInitiativeClaimed;
  final VoidCallback onShowPlayerCount;

  const OnePlayerLayout({
    super.key,
    required this.initiativePlayer,
    required this.onInitiativeClaimed,
    required this.onShowPlayerCount,
  });

  @override
  State<OnePlayerLayout> createState() => _OnePlayerLayoutState();
}

class _OnePlayerLayoutState extends State<OnePlayerLayout>
    with SingleTickerProviderStateMixin {
  int playerLife = 0;
  int playerLeaderId = 161; // Default leader ID
  int playerBaseId = 1; // Default base ID
  String playerName = "Player 1";

  // Timer variables
  bool _showTimer = false;
  bool _timerRunning = false;
  int _timerSeconds = 60 * 60; // 1 hour in seconds
  Timer? _timer;

  // Animation controller for timer panel sliding
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Create the slide animation for the timer panel
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start off-screen above
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  // Format seconds into mm:ss or hh:mm:ss
  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
  }

  // Toggle timer visibility
  void _toggleTimer() {
    setState(() {
      _showTimer = !_showTimer;
      if (_showTimer) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  // Start or pause the timer
  void _toggleTimerRunning() {
    setState(() {
      _timerRunning = !_timerRunning;

      if (_timerRunning) {
        // Start the timer
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            if (_timerSeconds > 0) {
              _timerSeconds--;
            } else {
              _timerRunning = false;
              _timer?.cancel();
            }
          });
        });
      } else {
        // Pause the timer
        _timer?.cancel();
      }
    });
  }

  // Reset the timer to 1 hour
  void _resetTimer() {
    setState(() {
      _timerSeconds = 60 * 60; // 1 hour
      _timerRunning = false;
      _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Main layout
          Column(
            children: [
              // Top Controls - positioned at the top in the middle
              Container(
                height: 80,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Reset Button
                    buildControlButton(
                      icon: Icons.refresh,
                      onTap: () => setState(() {
                        playerLife = 0;
                      }),
                    ),

                    // Return to player count
                    buildControlButton(
                      icon: Icons.people,
                      onTap: widget.onShowPlayerCount,
                    ),

                    // Timer Toggle Button
                    buildControlButton(
                      icon: Icons.timer,
                      color: _showTimer ? Colors.blue : Colors.white,
                      onTap: _toggleTimer,
                    ),

                    // Blast Button
                    InkWell(
                      onTap: () => setState(() {
                        if (playerLife >= 0) playerLife += 1;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "Blast",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    ),

                    // Info Button
                    buildControlButton(
                      icon: Icons.info,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => InfoDialog(
                          onDismissRequest: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Single Player Counter - takes up the rest of the screen
              Expanded(
                child: PlayerCounter(
                  isTopPlayer:
                      false, // Use normal orientation (not upside down)
                  baseId: playerBaseId,
                  leaderId: playerLeaderId,
                  life: playerLife,
                  playerName: playerName,
                  onNameChange: (newName) =>
                      setState(() => playerName = newName),
                  onBaseChange: (baseId) =>
                      setState(() => playerBaseId = baseId),
                  onLeaderChange: (leaderId) =>
                      setState(() => playerLeaderId = leaderId),
                  onLifeChange: (value) => setState(() => playerLife = value),
                  initiativePlayer: widget.initiativePlayer,
                  onInitiativeClaimed: widget.onInitiativeClaimed,
                  playerId: 0,
                ),
              ),
            ],
          ),

          // Timer Panel
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 80,
                color: Colors.black.withOpacity(0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Play/Pause button
                    IconButton(
                      icon: Icon(
                        _timerRunning ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: _toggleTimerRunning,
                    ),

                    // Timer display
                    Text(
                      _formatTime(_timerSeconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Reset button
                    IconButton(
                      icon: const Icon(
                        Icons.replay,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: _resetTimer,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Two Player Layout with Timer
class TwoPlayerLayout extends StatefulWidget {
  final int? initiativePlayer;
  final Function(int) onInitiativeClaimed;
  final VoidCallback onShowPlayerCount;

  const TwoPlayerLayout({
    super.key,
    required this.initiativePlayer,
    required this.onInitiativeClaimed,
    required this.onShowPlayerCount,
  });

  @override
  State<TwoPlayerLayout> createState() => _TwoPlayerLayoutState();
}

class _TwoPlayerLayoutState extends State<TwoPlayerLayout>
    with SingleTickerProviderStateMixin {
  int topLife = 0;
  int bottomLife = 0;
  int topLeaderId = 161;
  int bottomLeaderId = 168;
  int topBaseId = 1;
  int bottomBaseId = 3;
  List<String> playerNames = ["Player 1", "Player 2"];

  // Timer variables
  bool _showTimer = false;
  bool _timerRunning = false;
  int _timerSeconds = 60 * 60; // 1 hour in seconds
  Timer? _timer;

  // Animation controller for timer panel sliding
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Create the slide animation for the timer panel
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start off-screen above
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  // Format seconds into mm:ss or hh:mm:ss
  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
  }

  // Toggle timer visibility
  void _toggleTimer() {
    setState(() {
      _showTimer = !_showTimer;
      if (_showTimer) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  // Start or pause the timer
  void _toggleTimerRunning() {
    setState(() {
      _timerRunning = !_timerRunning;

      if (_timerRunning) {
        // Start the timer
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            if (_timerSeconds > 0) {
              _timerSeconds--;
            } else {
              _timerRunning = false;
              _timer?.cancel();
            }
          });
        });
      } else {
        // Pause the timer
        _timer?.cancel();
      }
    });
  }

  // Reset the timer to 1 hour
  void _resetTimer() {
    setState(() {
      _timerSeconds = 60 * 60; // 1 hour
      _timerRunning = false;
      _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Main layout
          Column(
            children: [
              // Top Player
              Expanded(
                flex: 1,
                child: PlayerCounter(
                  isTopPlayer: true,
                  baseId: topBaseId,
                  leaderId: topLeaderId,
                  life: topLife,
                  playerName: playerNames[0],
                  onNameChange: (newName) =>
                      setState(() => playerNames[0] = newName),
                  onBaseChange: (baseId) => setState(() => topBaseId = baseId),
                  onLeaderChange: (leaderId) =>
                      setState(() => topLeaderId = leaderId),
                  onLifeChange: (value) => setState(() => topLife = value),
                  initiativePlayer: widget.initiativePlayer,
                  onInitiativeClaimed: widget.onInitiativeClaimed,
                  playerId: 0,
                ),
              ),

              // Middle Controls
              Container(
                height: 60,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Return to player count
                    buildControlButton(
                      icon: Icons.people,
                      onTap: widget.onShowPlayerCount,
                    ),

                    // Reset Button
                    buildControlButton(
                      icon: Icons.refresh,
                      onTap: () => setState(() {
                        topLife = 0;
                        bottomLife = 0;
                      }),
                    ),

                    // Timer Toggle Button
                    buildControlButton(
                      icon: Icons.timer,
                      color: _showTimer ? Colors.blue : Colors.white,
                      onTap: _toggleTimer,
                    ),

                    // Blast Button
                    InkWell(
                      onTap: () => setState(() {
                        if (topLife >= 0) topLife += 1;
                        if (bottomLife >= 0) bottomLife += 1;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "Blast",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    ),

                    // Info Button
                    buildControlButton(
                      icon: Icons.info,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => InfoDialog(
                          onDismissRequest: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Player
              Expanded(
                flex: 1,
                child: PlayerCounter(
                  isTopPlayer: false,
                  baseId: bottomBaseId,
                  leaderId: bottomLeaderId,
                  life: bottomLife,
                  playerName: playerNames[1],
                  onNameChange: (newName) =>
                      setState(() => playerNames[1] = newName),
                  onBaseChange: (baseId) =>
                      setState(() => bottomBaseId = baseId),
                  onLeaderChange: (leaderId) =>
                      setState(() => bottomLeaderId = leaderId),
                  onLifeChange: (value) => setState(() => bottomLife = value),
                  initiativePlayer: widget.initiativePlayer,
                  onInitiativeClaimed: widget.onInitiativeClaimed,
                  playerId: 1,
                ),
              ),
            ],
          ),

          // Timer Panel
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 80,
                color: Colors.black.withOpacity(0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Play/Pause button
                    IconButton(
                      icon: Icon(
                        _timerRunning ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: _toggleTimerRunning,
                    ),

                    // Timer display
                    Text(
                      _formatTime(_timerSeconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Reset button
                    IconButton(
                      icon: const Icon(
                        Icons.replay,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: _resetTimer,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Three Player Layout
class ThreePlayerLayout extends StatefulWidget {
  final int? initiativePlayer;
  final Function(int) onInitiativeClaimed;
  final VoidCallback onShowPlayerCount;

  const ThreePlayerLayout({
    super.key,
    required this.initiativePlayer,
    required this.onInitiativeClaimed,
    required this.onShowPlayerCount,
  });

  @override
  State<ThreePlayerLayout> createState() => _ThreePlayerLayoutState();
}

class _ThreePlayerLayoutState extends State<ThreePlayerLayout> {
  List<int> playerLives = [0, 0, 0];
  List<int> playerLeaderIds = [161, 168, 164];
  List<int> playerBaseIds = [1, 3, 7];
  List<String> playerNames = ["Player 1", "Player 2", "Player 3"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Top Player
          Expanded(
            flex: 1,
            child: PlayerCounter(
              isTopPlayer: true,
              baseId: playerBaseIds[0],
              leaderId: playerLeaderIds[0],
              life: playerLives[0],
              playerName: playerNames[0],
              onNameChange: (newName) =>
                  setState(() => playerNames[0] = newName),
              onBaseChange: (baseId) =>
                  setState(() => playerBaseIds[0] = baseId),
              onLeaderChange: (leaderId) =>
                  setState(() => playerLeaderIds[0] = leaderId),
              onLifeChange: (value) => setState(() => playerLives[0] = value),
              initiativePlayer: widget.initiativePlayer,
              onInitiativeClaimed: widget.onInitiativeClaimed,
              playerId: 0,
            ),
          ),

          // Middle Controls
          _buildControlBar(),

          // Bottom Two Players (Side by Side)
          Expanded(
            flex: 1,
            child: Row(
              children: [
                // Left Bottom Player
                Expanded(
                  child: PlayerCounter(
                    isTopPlayer: false,
                    baseId: playerBaseIds[1],
                    leaderId: playerLeaderIds[1],
                    life: playerLives[1],
                    playerName: playerNames[1],
                    onNameChange: (newName) =>
                        setState(() => playerNames[1] = newName),
                    onBaseChange: (baseId) =>
                        setState(() => playerBaseIds[1] = baseId),
                    onLeaderChange: (leaderId) =>
                        setState(() => playerLeaderIds[1] = leaderId),
                    onLifeChange: (value) =>
                        setState(() => playerLives[1] = value),
                    initiativePlayer: widget.initiativePlayer,
                    onInitiativeClaimed: widget.onInitiativeClaimed,
                    playerId: 1,
                  ),
                ),

                // Right Bottom Player
                Expanded(
                  child: PlayerCounter(
                    isTopPlayer: false,
                    baseId: playerBaseIds[2],
                    leaderId: playerLeaderIds[2],
                    life: playerLives[2],
                    playerName: playerNames[2],
                    onNameChange: (newName) =>
                        setState(() => playerNames[2] = newName),
                    onBaseChange: (baseId) =>
                        setState(() => playerBaseIds[2] = baseId),
                    onLeaderChange: (leaderId) =>
                        setState(() => playerLeaderIds[2] = leaderId),
                    onLifeChange: (value) =>
                        setState(() => playerLives[2] = value),
                    initiativePlayer: widget.initiativePlayer,
                    onInitiativeClaimed: widget.onInitiativeClaimed,
                    playerId: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlBar() {
    return Container(
      height: 60,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Return to player count
          buildControlButton(
            icon: Icons.people,
            onTap: widget.onShowPlayerCount,
          ),

          // Reset Button
          buildControlButton(
            icon: Icons.refresh,
            onTap: () => setState(() {
              for (int i = 0; i < playerLives.length; i++) {
                playerLives[i] = 0;
              }
            }),
          ),

          // Blast Button
          InkWell(
            onTap: () => setState(() {
              for (int i = 0; i < playerLives.length; i++) {
                if (playerLives[i] >= 0) playerLives[i] += 1;
              }
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "Blast",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ),

          // Info Button
          buildControlButton(
            icon: Icons.info,
            onTap: () => showDialog(
              context: context,
              builder: (context) => InfoDialog(
                onDismissRequest: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Four Player Layout
class FourPlayerLayout extends StatefulWidget {
  final int? initiativePlayer;
  final Function(int) onInitiativeClaimed;
  final VoidCallback onShowPlayerCount;

  const FourPlayerLayout({
    super.key,
    required this.initiativePlayer,
    required this.onInitiativeClaimed,
    required this.onShowPlayerCount,
  });

  @override
  State<FourPlayerLayout> createState() => _FourPlayerLayoutState();
}

class _FourPlayerLayoutState extends State<FourPlayerLayout> {
  List<int> playerLives = [0, 0, 0, 0];
  List<int> playerLeaderIds = [161, 168, 164, 169];
  List<int> playerBaseIds = [1, 3, 7, 10];
  List<String> playerNames = ["Player 1", "Player 2", "Player 3", "Player 4"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Top Two Players (Side by Side)
          Expanded(
            flex: 1,
            child: Row(
              children: [
                // Left Top Player
                Expanded(
                  child: _buildPlayerCounter(0, true),
                ),

                // Right Top Player
                Expanded(
                  child: _buildPlayerCounter(1, true),
                ),
              ],
            ),
          ),

          // Middle Controls
          Container(
            height: 60,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Return to player count button
                buildControlButton(
                  icon: Icons.people,
                  onTap: widget.onShowPlayerCount,
                ),

                // Reset Button
                buildControlButton(
                  icon: Icons.refresh,
                  onTap: () => setState(() {
                    for (int i = 0; i < playerLives.length; i++) {
                      playerLives[i] = 0;
                    }
                  }),
                ),

                // Blast Button
                InkWell(
                  onTap: () => setState(() {
                    for (int i = 0; i < playerLives.length; i++) {
                      if (playerLives[i] >= 0) playerLives[i] += 1;
                    }
                  }),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "Blast",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ),

                // Info Button
                buildControlButton(
                  icon: Icons.info,
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => InfoDialog(
                      onDismissRequest: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Two Players (Side by Side)
          Expanded(
            flex: 1,
            child: Row(
              children: [
                // Left Bottom Player
                Expanded(
                  child: _buildPlayerCounter(2, false),
                ),

                // Right Bottom Player
                Expanded(
                  child: _buildPlayerCounter(3, false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCounter(int playerId, bool isTopPlayer) {
    return PlayerCounter(
      isTopPlayer: isTopPlayer,
      baseId: playerBaseIds[playerId],
      leaderId: playerLeaderIds[playerId],
      life: playerLives[playerId],
      playerName: playerNames[playerId],
      onNameChange: (newName) =>
          setState(() => playerNames[playerId] = newName),
      onBaseChange: (baseId) =>
          setState(() => playerBaseIds[playerId] = baseId),
      onLeaderChange: (leaderId) =>
          setState(() => playerLeaderIds[playerId] = leaderId),
      onLifeChange: (value) => setState(() => playerLives[playerId] = value),
      initiativePlayer: widget.initiativePlayer,
      onInitiativeClaimed: widget.onInitiativeClaimed,
      playerId: playerId,
    );
  }
}

// Five Player Layout
class FivePlayerLayout extends StatefulWidget {
  final int? initiativePlayer;
  final Function(int) onInitiativeClaimed;
  final VoidCallback onShowPlayerCount;

  const FivePlayerLayout({
    super.key,
    required this.initiativePlayer,
    required this.onInitiativeClaimed,
    required this.onShowPlayerCount,
  });

  @override
  State<FivePlayerLayout> createState() => _FivePlayerLayoutState();
}

class _FivePlayerLayoutState extends State<FivePlayerLayout> {
  List<int> playerLives = [0, 0, 0, 0, 0];
  List<int> playerLeaderIds = [161, 168, 164, 169, 137];
  List<int> playerBaseIds = [1, 3, 7, 10, 4];
  List<String> playerNames = [
    "Player 1",
    "Player 2",
    "Player 3",
    "Player 4",
    "Player 5"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Top Two Players (Side by Side)
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: _buildPlayerCounter(0, true)),
                Expanded(child: _buildPlayerCounter(1, true)),
              ],
            ),
          ),

          // Middle Player with controls
          Expanded(
            flex: 1,
            child: Row(
              children: [
                // Control Panel
                Container(
                  width: 60,
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildControlButton(
                        icon: Icons.people,
                        onTap: widget.onShowPlayerCount,
                      ),
                      buildControlButton(
                        icon: Icons.refresh,
                        onTap: () => setState(() {
                          for (int i = 0; i < playerLives.length; i++) {
                            playerLives[i] = 0;
                          }
                        }),
                      ),
                      buildControlButton(
                        icon: Icons.flash_on,
                        color: Colors.red,
                        onTap: () => setState(() {
                          for (int i = 0; i < playerLives.length; i++) {
                            if (playerLives[i] >= 0) playerLives[i] += 1;
                          }
                        }),
                      ),
                      buildControlButton(
                        icon: Icons.info,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => InfoDialog(
                            onDismissRequest: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Middle player
                Expanded(child: _buildPlayerCounter(4, false)),
              ],
            ),
          ),

          // Bottom Two Players (Side by Side)
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: _buildPlayerCounter(2, false)),
                Expanded(child: _buildPlayerCounter(3, false)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCounter(int playerId, bool isTopPlayer) {
    return PlayerCounter(
      isTopPlayer: isTopPlayer,
      baseId: playerBaseIds[playerId],
      leaderId: playerLeaderIds[playerId],
      life: playerLives[playerId],
      playerName: playerNames[playerId],
      onNameChange: (newName) =>
          setState(() => playerNames[playerId] = newName),
      onBaseChange: (baseId) =>
          setState(() => playerBaseIds[playerId] = baseId),
      onLeaderChange: (leaderId) =>
          setState(() => playerLeaderIds[playerId] = leaderId),
      onLifeChange: (value) => setState(() => playerLives[playerId] = value),
      initiativePlayer: widget.initiativePlayer,
      onInitiativeClaimed: widget.onInitiativeClaimed,
      playerId: playerId,
    );
  }
}

// Six Player Layout
class SixPlayerLayout extends StatefulWidget {
  final int? initiativePlayer;
  final Function(int) onInitiativeClaimed;
  final VoidCallback onShowPlayerCount;

  const SixPlayerLayout({
    super.key,
    required this.initiativePlayer,
    required this.onInitiativeClaimed,
    required this.onShowPlayerCount,
  });

  @override
  State<SixPlayerLayout> createState() => _SixPlayerLayoutState();
}

class _SixPlayerLayoutState extends State<SixPlayerLayout> {
  List<int> playerLives = [0, 0, 0, 0, 0, 0];
  List<int> playerLeaderIds = [161, 168, 164, 169, 137, 143];
  List<int> playerBaseIds = [1, 3, 7, 10, 4, 5];
  List<String> playerNames = [
    "Player 1",
    "Player 2",
    "Player 3",
    "Player 4",
    "Player 5",
    "Player 6"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Top row - 2 players
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: _buildPlayerCounter(0, true)),
                Expanded(child: _buildPlayerCounter(1, true)),
              ],
            ),
          ),

          // Middle row - 2 players
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: _buildPlayerCounter(2, true)),

                // Control Panel
                Container(
                  width: 60,
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildControlButton(
                        icon: Icons.people,
                        onTap: widget.onShowPlayerCount,
                      ),
                      buildControlButton(
                        icon: Icons.refresh,
                        onTap: () => setState(() {
                          for (int i = 0; i < playerLives.length; i++) {
                            playerLives[i] = 0;
                          }
                        }),
                      ),
                      buildControlButton(
                        icon: Icons.flash_on,
                        color: Colors.red,
                        onTap: () => setState(() {
                          for (int i = 0; i < playerLives.length; i++) {
                            if (playerLives[i] >= 0) playerLives[i] += 1;
                          }
                        }),
                      ),
                      buildControlButton(
                        icon: Icons.info,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => InfoDialog(
                            onDismissRequest: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(child: _buildPlayerCounter(3, true)),
              ],
            ),
          ),

          // Bottom row - 2 players
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: _buildPlayerCounter(4, false)),
                Expanded(child: _buildPlayerCounter(5, false)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCounter(int playerId, bool isTopPlayer) {
    return PlayerCounter(
      isTopPlayer: isTopPlayer,
      baseId: playerBaseIds[playerId],
      leaderId: playerLeaderIds[playerId],
      life: playerLives[playerId],
      playerName: playerNames[playerId],
      onNameChange: (newName) =>
          setState(() => playerNames[playerId] = newName),
      onBaseChange: (baseId) =>
          setState(() => playerBaseIds[playerId] = baseId),
      onLeaderChange: (leaderId) =>
          setState(() => playerLeaderIds[playerId] = leaderId),
      onLifeChange: (value) => setState(() => playerLives[playerId] = value),
      initiativePlayer: widget.initiativePlayer,
      onInitiativeClaimed: widget.onInitiativeClaimed,
      playerId: playerId,
    );
  }
}
