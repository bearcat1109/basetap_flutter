import 'package:flutter/material.dart';
import 'dart:math';
import 'models.dart';
import 'dialogs.dart';

// Player counter component
class PlayerCounter extends StatefulWidget {
  final bool isTopPlayer;
  final int baseId;
  final int life;
  final String playerName;
  final Function(String) onNameChange;
  final Function(int) onLifeChange;
  final int? initiativePlayer;
  final Function(int)? onInitiativeClaimed;
  final int playerId;
  final Function(int) onBaseChange;
  final int leaderId;
  final Function(int) onLeaderChange;
  final Function(int)? onPlayerDefeated;

  const PlayerCounter({
    super.key,
    required this.isTopPlayer,
    required this.baseId,
    required this.life,
    required this.playerName,
    required this.onNameChange,
    required this.onLifeChange,
    required this.initiativePlayer,
    required this.onInitiativeClaimed,
    required this.playerId,
    required this.onBaseChange,
    required this.leaderId,
    required this.onLeaderChange,
    this.onPlayerDefeated,
  });

  @override
  State<PlayerCounter> createState() => _PlayerCounterState();
}

class _PlayerCounterState extends State<PlayerCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  bool showDamageIndicator = false;
  int currentDamage = 0;
  final damageAccumulator = DamageAccumulator();

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _handleLifeChange(int newDamage) {
    // Get the base max health
    final base = Base.findById(widget.baseId);
    final baseMaxHealth = base?.maxHealth ?? 30;

    // If player is already dead (at or above max health), do nothing
    if (widget.life >= baseMaxHealth + 1) return;

    final newLife = widget.life + newDamage;

    if (newLife >= 0) {
      final accumulatedDamage = damageAccumulator.addDamage(newDamage);

      setState(() {
        currentDamage = accumulatedDamage;
        showDamageIndicator = true;
      });

      widget.onLifeChange(newLife);

      // Trigger shake animation when taking damage
      if (newDamage > 0) {
        _shakeController.forward(from: 0.0);
      }

      // Check if player just died (reached max health)
      if (newLife >= baseMaxHealth && widget.life < baseMaxHealth) {
        // Player just died, trigger victory callback
        widget.onPlayerDefeated?.call(widget.playerId);
      }

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            showDamageIndicator = false;
          });
        }
      });
    }
  }

  void _showPlayerNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PlayerNameDialog(
        initialName: widget.playerName,
        baseId: widget.baseId,
        leaderId: widget.leaderId,
        onDismissRequest: () {
          Navigator.of(context).pop();
        },
        onConfirm: (name, baseId, leaderId) {
          widget.onNameChange(name);
          widget.onBaseChange(baseId);
          widget.onLeaderChange(leaderId);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final base = Base.findById(widget.baseId);
    final baseMaxHealth = base?.maxHealth ?? 30;
    final baseName = base?.baseName ?? "Select Base";
    final baseTypeColor = base?.color ?? Colors.grey;

    final leader = Leader.findById(widget.leaderId);

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        // Create a shake effect
        double offsetX = 0.0;
        if (_shakeController.isAnimating) {
          offsetX = sin(_shakeController.value * 10 * pi) * 5.0;
        }

        return Transform.translate(
          offset: Offset(offsetX, 0.0),
          child: child,
        );
      },
      child: RotatedBox(
        quarterTurns: widget.isTopPlayer ? 2 : 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            image: leader?.imagePath != null
                ? DecorationImage(
                    image: AssetImage(leader!.imagePath),
                    fit: BoxFit.cover,
                    opacity: 0.7, // Adjust opacity as needed
                  )
                : null,
          ),
          child: Stack(
            children: [
              // Base banner at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 24,
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: Text(
                      baseName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        shadows: [Shadow(color: Colors.black, blurRadius: 4.0)],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),

              // Clickable areas for life adjustment
              Row(
                children: [
                  // Minus side
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _handleLifeChange(-1), // Heal
                      behavior: HitTestBehavior.opaque,
                      child: Container(),
                    ),
                  ),
                  // Plus side
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _handleLifeChange(1), // Damage
                      behavior: HitTestBehavior.opaque,
                      child: Container(),
                    ),
                  ),
                ],
              ),

              // Life total with damage indicator
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.life >= baseMaxHealth
                          ? getRandomDeathMessage()
                          : "-${widget.life}+",
                      style: TextStyle(
                        color: widget.life >= baseMaxHealth
                            ? Colors.red
                            : Colors.white,
                        fontSize: widget.life >= baseMaxHealth ? 30 : 80,
                        shadows: const [
                          Shadow(color: Colors.black, blurRadius: 12.0)
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (showDamageIndicator)
                      Text(
                        currentDamage > 0
                            ? "+$currentDamage"
                            : "$currentDamage",
                        style: TextStyle(
                          color: currentDamage < 0 ? Colors.green : Colors.red,
                          fontSize: 36,
                        ),
                      ),
                  ],
                ),
              ),

              // Dead player overlay
              if (widget.life >= baseMaxHealth)
                Container(color: Colors.black.withOpacity(0.7)),

              // Player name and initiative
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    // Initiative token
                    if (widget.onInitiativeClaimed != null)
                      GestureDetector(
                        onTap: () =>
                            widget.onInitiativeClaimed!(widget.playerId),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: widget.initiativePlayer == widget.playerId
                                ? Colors.yellow.withOpacity(0.7)
                                : Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    // Player name
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showPlayerNameDialog(context),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: baseTypeColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              widget.playerName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 8.0)
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
