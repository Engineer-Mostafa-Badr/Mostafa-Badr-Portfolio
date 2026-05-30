import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';

/// Konami code easter egg — listens for ↑↑↓↓←→←→BA and triggers
/// a celebratory confetti overlay + a short personal note.
///
/// Wraps the entire app so the listener is always active. Pure delight —
/// no impact on regular users, but devs who notice the keys feel like
/// they discovered a hidden room.
class KonamiEasterEgg extends StatefulWidget {
  final Widget child;
  const KonamiEasterEgg({super.key, required this.child});

  @override
  State<KonamiEasterEgg> createState() => _KonamiEasterEggState();
}

class _KonamiEasterEggState extends State<KonamiEasterEgg> {
  static const _sequence = <LogicalKeyboardKey>[
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.keyB,
    LogicalKeyboardKey.keyA,
  ];

  final List<LogicalKeyboardKey> _buffer = [];
  final FocusNode _focusNode = FocusNode(skipTraversal: true, canRequestFocus: true);
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
    // Grab focus on first frame so key events come straight to us.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    _buffer.add(event.logicalKey);
    if (_buffer.length > _sequence.length) {
      _buffer.removeAt(0);
    }

    final matches = _buffer.length == _sequence.length &&
        List.generate(_sequence.length, (i) => _buffer[i] == _sequence[i])
            .every((b) => b);

    if (matches) {
      _buffer.clear();
      _trigger();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _trigger() {
    if (!mounted || _showOverlay) return;
    setState(() => _showOverlay = true);
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) setState(() => _showOverlay = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _onKey,
      autofocus: true,
      child: Stack(
        children: [
          widget.child,
          if (_showOverlay)
            Positioned.fill(
              child: _KonamiOverlay(onDismiss: () {
                if (mounted) setState(() => _showOverlay = false);
              }),
            ),
        ],
      ),
    );
  }
}

class _KonamiOverlay extends StatelessWidget {
  final VoidCallback onDismiss;
  const _KonamiOverlay({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final ar = isArabic(context);
    return GestureDetector(
      onTap: onDismiss,
      child: Container(
        color: Colors.black.withValues(alpha: 0.55),
        child: Stack(
          children: [
            // Confetti background
            ...List.generate(40, (i) {
              return _ConfettiPiece(seed: i);
            }),
            // Centered card
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 28,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                constraints: const BoxConstraints(maxWidth: 460),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0E152B), Color(0xFF1A1130)],
                  ),
                  border: Border.all(
                    color: const Color(0xFFFFD700).withValues(alpha: 0.55),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.35),
                      blurRadius: 40,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '🎮',
                      style: TextStyle(fontSize: 56),
                    )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scaleXY(begin: 0.9, end: 1.1, duration: 800.ms),
                    const SizedBox(height: 14),
                    ShaderMask(
                      shaderCallback: (rect) => const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFF40C4FF)],
                      ).createShader(rect),
                      child: Text(
                        ar ? 'لقيت السرّ! 🚀' : 'You found the secret! 🚀',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      ar
                          ? 'لو وصلت لـ Konami code، أنت مطور حقيقي. خلاص محتاج اعمل معاك call. 😄'
                          : 'If you knew the Konami code, you’re my kind of dev. Let’s talk. 😄',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 13.5,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      ar ? '(اضغط في أي مكان للإغلاق)' : '(tap anywhere to close)',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .scale(
                    begin: const Offset(0.7, 0.7),
                    end: const Offset(1, 1),
                    curve: Curves.elasticOut,
                    duration: 700.ms,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfettiPiece extends StatelessWidget {
  final int seed;
  const _ConfettiPiece({required this.seed});

  @override
  Widget build(BuildContext context) {
    // Deterministic randomness per seed so each rebuild is the same.
    final rnd = math.Random(seed);
    final colors = const [
      Color(0xFFFFD700),
      Color(0xFF40C4FF),
      Color(0xFF9C7BFF),
      Color(0xFF34D399),
      Color(0xFFFF8A65),
    ];
    final color = colors[rnd.nextInt(colors.length)];
    final size = MediaQuery.of(context).size;
    final startX = rnd.nextDouble() * size.width;
    final endY = size.height + 40;
    final delay = rnd.nextInt(1200);
    final pieceSize = 6.0 + rnd.nextDouble() * 6.0;

    return Positioned(
      left: startX,
      top: -20,
      child: Container(
        width: pieceSize,
        height: pieceSize,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(rnd.nextBool() ? 0 : 2),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 6),
          ],
        ),
      )
          .animate(delay: Duration(milliseconds: delay))
          .moveY(begin: 0, end: endY, duration: 3.seconds, curve: Curves.easeIn)
          .rotate(begin: 0, end: rnd.nextDouble() * 4, duration: 3.seconds)
          .fadeOut(delay: 2500.ms, duration: 500.ms),
    );
  }
}
