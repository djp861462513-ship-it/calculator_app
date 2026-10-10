import 'dart:math' as math;
import 'dart:ui';
import 'particle.dart';

class Emitter {
  double x;
  double y;
  double rate;
  double accumulated = 0;
  final List<Particle> particles;
  final int maxParticles;

  Emitter({
    required this.x,
    required this.y,
    this.rate = 1,
    this.maxParticles = 200,
  }) : particles = [];

  void emit(int count, Size size) {}

  void update(double dt, Size size) {
    for (int i = particles.length - 1; i >= 0; i--) {
      particles[i].update(dt);
      if (!particles[i].isAlive ||
          particles[i].x < -50 ||
          particles[i].x > size.width + 50 ||
          particles[i].y > size.height + 50 ||
          particles[i].y < -50) {
        particles.removeAt(i);
      }
    }
    accumulated += rate * dt;
    if (accumulated >= 1) {
      final count = accumulated.toInt();
      accumulated -= count;
      emit(count, size);
    }
  }

  void draw(Canvas canvas, Paint paint, {BlendMode blendMode = BlendMode.srcOver}) {
    for (final p in particles) {
      p.draw(canvas, paint, blendMode: blendMode);
    }
  }

  int get particleCount => particles.length;
}

class FireworkEmitter extends Emitter {
  final List<Color> colors;
  final math.Random rng;
  double nextBurst = 0;
  double burstInterval;

  FireworkEmitter({
    required double x,
    required double y,
    required this.colors,
    this.burstInterval = 2.0,
    int maxParticles = 500,
  })  : rng = math.Random(),
        super(x: x, y: y, rate: 0, maxParticles: maxParticles);

  @override
  void update(double dt, Size size) {
    super.update(dt, size);

    nextBurst -= dt;
    if (nextBurst <= 0) {
      nextBurst = burstInterval * (0.6 + rng.nextDouble() * 0.8);
      x = size.width * (0.15 + rng.nextDouble() * 0.7);
      y = size.height * (0.15 + rng.nextDouble() * 0.4);
      _burst();
    }
  }

  void burst() {
    final color = colors[rng.nextInt(colors.length)];
    final count = 40 + rng.nextInt(30);

    for (int i = 0; i < count; i++) {
      final angle = (i / count) * 2 * math.pi + rng.nextDouble() * 0.3;
      final speed = 80 + rng.nextDouble() * 120;
      particles.add(Particle(
        x: x,
        y: y,
        vx: math.cos(angle) * speed,
        vy: math.sin(angle) * speed,
        ay: 80,
        life: 1.5 + rng.nextDouble() * 0.8,
        maxLife: 2.3,
        size: 2 + rng.nextDouble() * 2,
        color: color,
        rotationSpeed: rng.nextDouble() * 4 - 2,
        shape: Particle.shapeSpark,
        trail: [],
      ));
    }

    for (int i = 0; i < 8; i++) {
      final angle = rng.nextDouble() * 2 * math.pi;
      final speed = 20 + rng.nextDouble() * 40;
      particles.add(Particle(
        x: x,
        y: y,
        vx: math.cos(angle) * speed,
        vy: math.sin(angle) * speed,
        ay: 40,
        life: 2.0 + rng.nextDouble(),
        maxLife: 3.0,
        size: 4 + rng.nextDouble() * 3,
        color: color,
        rotationSpeed: rng.nextDouble() * 6,
        shape: Particle.shapeStar,
        trail: [],
      ));
    }
  }
}

class CherryBlossomEmitter extends Emitter {
  final List<Color> colors;
  final math.Random rng = math.Random();

  CherryBlossomEmitter({
    required List<Color> colors,
    int maxParticles = 80,
  })  : colors = colors,
        super(x: 0, y: 0, rate: 8, maxParticles: maxParticles);

  @override
  void emit(int count, Size size) {
    for (int i = 0; i < count; i++) {
      final side = rng.nextInt(3);
      double px, py, vx, vy;
      switch (side) {
        case 0:
          px = rng.nextDouble() * size.width;
          py = -20;
          vx = (rng.nextDouble() - 0.5) * 30;
          vy = 20 + rng.nextDouble() * 30;
          break;
        case 1:
          px = -20;
          py = rng.nextDouble() * size.height * 0.5;
          vx = 20 + rng.nextDouble() * 30;
          vy = 10 + rng.nextDouble() * 20;
          break;
        default:
          px = size.width + 20;
          py = rng.nextDouble() * size.height * 0.5;
          vx = -20 - rng.nextDouble() * 30;
          vy = 10 + rng.nextDouble() * 20;
      }
      particles.add(Particle(
        x: px,
        y: py,
        vx: vx,
        vy: vy,
        ay: 5,
        life: 6 + rng.nextDouble() * 4,
        maxLife: 10,
        size: 5 + rng.nextDouble() * 5,
        color: colors[rng.nextInt(colors.length)],
        rotationSpeed: (rng.nextDouble() - 0.5) * 3,
        shape: Particle.shapePetal,
        trail: [],
      ));
    }
  }

  @override
  void update(double dt, Size size) {
    for (int i = particles.length - 1; i >= 0; i--) {
      final p = particles[i];
      p.vx += math.sin(p.y * 0.01 + p.life) * 15 * dt;
      p.update(dt);
      if (!p.isAlive ||
          p.x < -50 || p.x > size.width + 50 ||
          p.y > size.height + 50) {
        particles.removeAt(i);
      }
    }
    accumulated += rate * dt;
    if (accumulated >= 1) {
      final count = accumulated.toInt();
      accumulated -= count;
      emit(count, size);
    }
  }
}

class BubbleEmitter extends Emitter {
  final List<Color> colors;
  final math.Random rng = math.Random();

  BubbleEmitter({
    required List<Color> colors,
    int maxParticles = 60,
  })  : colors = colors,
        super(x: 0, y: 0, rate: 5, maxParticles: maxParticles);

  @override
  void emit(int count, Size size) {
    for (int i = 0; i < count; i++) {
      particles.add(Particle(
        x: rng.nextDouble() * size.width,
        y: size.height + 10,
        vx: (rng.nextDouble() - 0.5) * 20,
        vy: -30 - rng.nextDouble() * 40,
        life: 5 + rng.nextDouble() * 5,
        maxLife: 10,
        size: 3 + rng.nextDouble() * 8,
        color: colors[rng.nextInt(colors.length)],
        shape: Particle.shapeCircle,
        trail: [],
      ));
    }
  }

  @override
  void update(double dt, Size size) {
    for (int i = particles.length - 1; i >= 0; i--) {
      final p = particles[i];
      p.vx += math.sin(p.y * 0.02) * 10 * dt;
      p.update(dt);
      if (!p.isAlive || p.y < -50) {
        particles.removeAt(i);
      }
    }
    accumulated += rate * dt;
    if (accumulated >= 1) {
      final count = accumulated.toInt();
      accumulated -= count;
      emit(count, size);
    }
  }
}

class DiamondSparkleEmitter extends Emitter {
  final List<Color> colors;
  final math.Random rng = math.Random();
  double time = 0;

  DiamondSparkleEmitter({
    required List<Color> colors,
    int maxParticles = 50,
  })  : colors = colors,
        super(x: 0, y: 0, rate: 10, maxParticles: maxParticles);

  @override
  void emit(int count, Size size) {
    for (int i = 0; i < count; i++) {
      particles.add(Particle(
        x: rng.nextDouble() * size.width,
        y: rng.nextDouble() * size.height,
        vx: 0,
        vy: 0,
        life: 0.5 + rng.nextDouble() * 1.5,
        maxLife: 2.0,
        size: 4 + rng.nextDouble() * 6,
        color: colors[rng.nextInt(colors.length)],
        rotationSpeed: rng.nextDouble() * 8 - 4,
        shape: Particle.shapeDiamond,
        trail: [],
      ));
    }
  }

  @override
  void update(double dt, Size size) {
    time += dt;
    for (int i = particles.length - 1; i >= 0; i--) {
      particles[i].life -= dt;
      if (!particles[i].isAlive) {
        particles.removeAt(i);
      }
    }
    if (rng.nextDouble() < dt * 15) {
      emit(1 + rng.nextInt(3), size);
    }
  }
}

class StreamEmitter extends Emitter {
  final List<Color> colors;
  final math.Random rng = math.Random();

  StreamEmitter({
    required List<Color> colors,
    int maxParticles = 150,
  })  : colors = colors,
        super(x: 0, y: 0, rate: 20, maxParticles: maxParticles);

  @override
  void emit(int count, Size size) {
    for (int i = 0; i < count; i++) {
      final fromLeft = rng.nextBool();
      particles.add(Particle(
        x: fromLeft ? -10 : size.width + 10,
        y: rng.nextDouble() * size.height,
        vx: (fromLeft ? 1 : -1) * (40 + rng.nextDouble() * 60),
        vy: (rng.nextDouble() - 0.5) * 10,
        life: 3 + rng.nextDouble() * 2,
        maxLife: 5,
        size: 2 + rng.nextDouble() * 2,
        color: colors[rng.nextInt(colors.length)],
        shape: Particle.shapeCircle,
        trail: [],
      ));
    }
  }
}

class ConstellationEmitter extends Emitter {
  final List<Color> colors;
  final math.Random rng = math.Random();
  late List<_Node> nodes;

  ConstellationEmitter({
    required List<Color> colors,
    int maxParticles = 80,
  })  : colors = colors,
        super(x: 0, y: 0, rate: 0, maxParticles: maxParticles);

  void init(Size size) {
    nodes = List.generate(40, (_) => _Node(
      x: rng.nextDouble() * size.width,
      y: rng.nextDouble() * size.height,
      vx: (rng.nextDouble() - 0.5) * 8,
      vy: (rng.nextDouble() - 0.5) * 8,
      size: 1.5 + rng.nextDouble() * 2,
      twinkle: rng.nextDouble() * 2 * math.pi,
      color: colors[rng.nextInt(colors.length)],
    ));
  }

  @override
  void update(double dt, Size size) {
    if (nodes.isEmpty) init(size);
    for (final n in nodes) {
      n.x += n.vx * dt;
      n.y += n.vy * dt;
      n.twinkle += dt * 2;
      if (n.x < 0 || n.x > size.width) n.vx *= -1;
      if (n.y < 0 || n.y > size.height) n.vy *= -1;
    }
  }

  void draw(Canvas canvas, Paint paint, {BlendMode blendMode = BlendMode.srcOver}) {
    if (nodes.isEmpty) return;
    paint.blendMode = blendMode;
    paint.strokeWidth = 0.5;

    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final dx = nodes[i].x - nodes[j].x;
        final dy = nodes[i].y - nodes[j].y;
        final dist = math.sqrt(dx * dx + dy * dy);
        if (dist < 80) {
          final alpha = (1 - dist / 80) * 0.3;
          paint.color = nodes[i].color.withOpacity(alpha);
          canvas.drawLine(
            Offset(nodes[i].x, nodes[i].y),
            Offset(nodes[j].x, nodes[j].y),
            paint,
          );
        }
      }
    }

    paint.style = PaintingStyle.fill;
    for (final n in nodes) {
      final twinkle = 0.5 + 0.5 * (math.sin(n.twinkle)).abs();
      paint.color = n.color.withOpacity(twinkle);
      canvas.drawCircle(Offset(n.x, n.y), n.size, paint);
      paint.color = n.color.withOpacity(twinkle * 0.2);
      canvas.drawCircle(Offset(n.x, n.y), n.size * 3, paint);
    }
  }

  @override
  int get particleCount => nodes.length;
}

class _Node {
  double x, y, vx, vy, size, twinkle;
  Color color;
  _Node({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.twinkle,
    required this.color,
  });
}
