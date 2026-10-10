import 'package:flutter/material.dart';
import '../effects/emitters.dart';

class FireworkOverlay extends StatefulWidget {
  final List<Color> colors;
  final Widget child;
  final VoidCallback? onFirework;

  const FireworkOverlay({
    super.key,
    required this.colors,
    required this.child,
    this.onFirework,
  });

  @override
  State<FireworkOverlay> createState() => FireworkOverlayState();
}

class FireworkOverlayState extends State<FireworkOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  FireworkEmitter? _emitter;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void triggerFirework(Offset position) {
    _emitter = FireworkEmitter(
      x: position.dx,
      y: position.dy,
      colors: widget.colors,
      burstInterval: 999,
      maxParticles: 300,
    );
    _emitter!.burst();
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_emitter != null)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _FireworkPainter(
                    emitter: _emitter!,
                    progress: _controller.value,
                  ),
                  child: Container(),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _FireworkPainter extends CustomPainter {
  final FireworkEmitter emitter;
  final double progress;
  final Paint _paint = Paint();

  _FireworkPainter({required this.emitter, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    emitter.update(1 / 60, size);
    emitter.draw(canvas, _paint, blendMode: BlendMode.plus);
  }

  @override
  bool shouldRepaint(covariant _FireworkPainter old) => true;
}
