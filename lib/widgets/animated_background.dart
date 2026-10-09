import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../skins/skin_animation_config.dart';

class AnimatedBackground extends StatefulWidget {
  final SkinAnimationConfig config;
  final Color baseColor;
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.config,
    required this.baseColor,
    required this.child,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.config.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.config.hasAnimation) {
      return widget.child;
    }

    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _BackgroundPainter(
                  config: widget.config,
                  progress: _controller.value,
                  baseColor: widget.baseColor,
                ),
                child: Container(),
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final SkinAnimationConfig config;
  final double progress;
  final Color baseColor;

  _BackgroundPainter({
    required this.config,
    required this.progress,
    required this.baseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (config.type) {
      case AnimationType.aurora:
        _drawAurora(canvas, size);
        break;
      case AnimationType.starfield:
        _drawStarfield(canvas, size);
        break;
      case AnimationType.pulsingGlow:
        _drawPulsingGlow(canvas, size);
        break;
      case AnimationType.flowingParticles:
        _drawFlowingParticles(canvas, size);
        break;
      case AnimationType.rainbowShift:
        _drawRainbowShift(canvas, size);
        break;
      case AnimationType.shimmerWave:
        _drawShimmerWave(canvas, size);
        break;
      case AnimationType.rotatingGradient:
        _drawRotatingGradient(canvas, size);
        break;
      case AnimationType.floatingOrbs:
        _drawFloatingOrbs(canvas, size);
        break;
      case AnimationType.none:
        break;
    }
  }

  void _drawAurora(Canvas canvas, Size size) {
    final colors = config.particleColors;
    final w = size.width;
    final h = size.height;
    final paint = Paint();

    for (int i = 0; i < colors.length; i++) {
      final phase = progress * 2 * math.pi + i * math.pi / 2;
      final yOffset = h * 0.15 + h * 0.15 * i;
      final amplitude = 60.0 + 20 * math.sin(phase);
      final centerOffset = math.sin(phase) * 80;

      final path = Path();
      path.moveTo(0, yOffset);

      for (double x = 0; x <= w; x += 8) {
        final wave =
            amplitude * math.sin(x / w * 3 * math.pi + phase) + centerOffset;
        path.lineTo(x, yOffset + wave);
      }
      path.lineTo(w, yOffset + 200);
      path.lineTo(0, yOffset + 200);
      path.close();

      paint.shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          colors[i].withOpacity(0.25 * config.intensity),
          colors[i].withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, yOffset - 100, w, 300));

      canvas.drawPath(path, paint);
    }

    final stars = _getStars(60, size);
    for (final s in stars) {
      final twinkle = 0.4 + 0.6 * (math.sin(progress * 4 * math.pi + s.phase)).abs();
      canvas.drawCircle(
        Offset(s.x * w, s.y * h),
        s.size,
        Paint()..color = Colors.white.withOpacity(twinkle * 0.6 * config.intensity),
      );
    }
  }

  void _drawStarfield(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final colors = config.particleColors;
    final stars = _getStars(120, size);

    final nebulaPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment(0.3 + progress * 0.2, -0.2),
        radius: 0.8,
        colors: [
          colors.isNotEmpty ? colors[3].withOpacity(0.08 * config.intensity) : Colors.transparent,
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, nebulaPaint);

    for (final s in stars) {
      final drift = (progress + s.phase * 0.1) % 1.0;
      final twinkle = 0.3 + 0.7 * (math.sin(progress * 3 * math.pi + s.phase * 2 * math.pi)).abs();
      final colorVal = (s.phase * 1000).toInt() % colors.length;
      final color = colors[colorVal.clamp(0, colors.length - 1)];
      canvas.drawCircle(
        Offset(s.x * w, ((s.y + drift * 0.05) % 1.0) * h),
        s.size,
        Paint()..color = color.withOpacity(twinkle * config.intensity),
      );

      if (s.size > 1.5) {
        canvas.drawCircle(
          Offset(s.x * w, ((s.y + drift * 0.05) % 1.0) * h),
          s.size * 3,
          Paint()..color = color.withOpacity(twinkle * 0.15 * config.intensity),
        );
      }
    }
  }

  void _drawPulsingGlow(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final colors = config.particleColors;

    final pulse = 0.5 + 0.5 * math.sin(progress * 2 * math.pi);

    for (int i = 0; i < colors.length; i++) {
      final centerY = h * (0.3 + 0.2 * i);
      final radius = (100 + 80 * pulse) * (1 + i * 0.3);
      final centerX = w * 0.5 + math.sin(progress * 2 * math.pi + i) * w * 0.2;

      canvas.drawCircle(
        Offset(centerX, centerY),
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [
              colors[i].withOpacity(0.35 * config.intensity * (0.5 + 0.5 * pulse)),
              colors[i].withOpacity(0.0),
            ],
          ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius)),
      );
    }

    final embers = _getStars(30, size);
    for (final e in embers) {
      final drift = (progress * e.speed + e.phase) % 1.0;
      final y = ((e.y - drift) % 1.0 + 1) % 1.0;
      final x = e.x + math.sin(progress * 2 * math.pi + e.phase * 2 * math.pi) * 0.02;
      final emberColor = colors[(e.phase * 1000).toInt() % colors.length];
      final emberSize = e.size * (0.5 + 0.5 * math.sin(progress * 4 * math.pi + e.phase * 2 * math.pi));

      canvas.drawCircle(
        Offset(x * w, y * h),
        emberSize * 2,
        Paint()..color = emberColor.withOpacity(0.3 * config.intensity),
      );
      canvas.drawCircle(
        Offset(x * w, y * h),
        emberSize,
        Paint()..color = emberColor.withOpacity(0.6 * config.intensity),
      );
    }
  }

  void _drawFlowingParticles(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final colors = config.particleColors;

    for (int layer = 0; layer < 3; layer++) {
      final layerProgress = (progress + layer * 0.33) % 1.0;
      final path = Path();

      final baseY = h * (0.2 + 0.25 * layer);
      final amplitude = 40.0 + layer * 20;
      final wavelength = 1.5 + layer * 0.5;

      path.moveTo(0, baseY);
      for (double x = 0; x <= w; x += 5) {
        final wave = amplitude *
            math.sin(x / w * wavelength * math.pi + layerProgress * 2 * math.pi) *
            math.cos(layerProgress * math.pi + layer);
        path.lineTo(x, baseY + wave);
      }
      path.lineTo(w, baseY + 60);
      path.lineTo(0, baseY + 60);
      path.close();

      final color = colors[layer % colors.length];
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );
    }
  }

  void _drawRainbowShift(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final colors = config.particleColors;

    final offset = progress * colors.length;
    final shiftedColors = <Color>[];
    for (int i = 0; i < colors.length; i++) {
      final idx = (i + offset) % colors.length;
      shiftedColors.add(colors[idx.toInt() % colors.length]);
    }

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment(-1 + progress * 2, -1),
        end: Alignment(1 + progress * 2, 1),
        colors: shiftedColors.map((c) => c.withOpacity(0.15 * config.intensity)).toList(),
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint);

    for (int i = 0; i < 8; i++) {
      final x = ((progress * 0.5 + i * 0.125) % 1.0) * w;
      final y = h * 0.5 + math.sin(progress * 2 * math.pi + i) * h * 0.3;
      final color = colors[(i + offset.toInt()) % colors.length];
      final radius = 20 + 15 * math.sin(progress * 4 * math.pi + i);

      canvas.drawCircle(
        Offset(x, y),
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [
              color.withOpacity(0.2 * config.intensity),
              color.withOpacity(0.0),
            ],
          ).createShader(Rect.fromCircle(center: Offset(x, y), radius: radius)),
      );
    }
  }

  void _drawShimmerWave(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final colors = config.particleColors;

    for (int i = 0; i < colors.length; i++) {
      final waveProgress = (progress + i / colors.length) % 1.0;
      final x = waveProgress * w * 1.5 - w * 0.25;
      final path = Path();
      path.moveTo(x - 100, 0);
      path.lineTo(x, 0);
      path.lineTo(x + 50, h);
      path.lineTo(x - 50, h);
      path.close();

      canvas.drawPath(
        path,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors[i].withOpacity(0.0),
              colors[i].withOpacity(0.15 * config.intensity),
              colors[i].withOpacity(0.0),
            ],
          ).createShader(Rect.fromLTWH(x - 100, 0, 200, h)),
      );
    }

    final particles = _getStars(40, size);
    for (final p in particles) {
      final drift = (progress * p.speed + p.phase) % 1.0;
      final y = ((p.y - drift) % 1.0 + 1) % 1.0;
      final color = colors[(p.phase * 1000).toInt() % colors.length];
      final opacity = (0.3 + 0.7 * (math.sin(progress * 3 * math.pi + p.phase * 2 * math.pi)).abs()) * config.intensity;

      canvas.drawCircle(
        Offset(p.x * w, y * h),
        p.size * 1.5,
        Paint()..color = color.withOpacity(opacity * 0.3),
      );
      canvas.drawCircle(
        Offset(p.x * w, y * h),
        p.size * 0.8,
        Paint()..color = color.withOpacity(opacity * 0.7),
      );
    }
  }

  void _drawRotatingGradient(Canvas canvas, Size size) {
    final colors = config.particleColors;
    if (colors.isEmpty) return;

    final angle = progress * 2 * math.pi;
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..shader = SweepGradient(
        center: Alignment(
          center.dx / size.width * 2 - 1,
          center.dy / size.height * 2 - 1,
        ),
        startAngle: angle,
        endAngle: angle + 2 * math.pi,
        colors: colors.map((c) => c.withOpacity(0.12 * config.intensity)).toList(),
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint);
  }

  void _drawFloatingOrbs(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final colors = config.particleColors;

    for (int i = 0; i < 8; i++) {
      final phase = i * math.pi / 4;
      final x = (0.15 + 0.7 * ((i / 8.0 + progress * 0.3) % 1.0)) * w;
      final y = (0.2 + 0.6 * math.sin(progress * 2 * math.pi + phase)) * h;
      final color = colors[i % colors.length];
      final radius = 40 + 30 * math.sin(progress * 2 * math.pi + phase * 2);

      canvas.drawCircle(
        Offset(x, y),
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [
              color.withOpacity(0.2 * config.intensity),
              color.withOpacity(0.0),
            ],
          ).createShader(Rect.fromCircle(center: Offset(x, y), radius: radius)),
      );
    }
  }

  List<_Star> _getStars(int count, Size size) {
    final rng = math.Random(42);
    return List.generate(count, (_) {
      return _Star(
        x: rng.nextDouble(),
        y: rng.nextDouble(),
        size: 0.5 + rng.nextDouble() * 2.5,
        phase: rng.nextDouble(),
        speed: 0.3 + rng.nextDouble() * 0.7,
      );
    });
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter old) =>
      old.progress != progress;
}

class _Star {
  final double x;
  final double y;
  final double size;
  final double phase;
  final double speed;

  _Star({
    required this.x,
    required this.y,
    required this.size,
    required this.phase,
    required this.speed,
  });
}
