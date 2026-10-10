import 'dart:math' as math;
import 'dart:ui';

class Particle {
  double x;
  double y;
  double vx;
  double vy;
  double ax;
  double ay;
  double life;
  double maxLife;
  double size;
  Color color;
  List<Offset> trail;
  double rotation;
  double rotationSpeed;
  int shape;

  static const int shapeCircle = 0;
  static const int shapeDiamond = 1;
  static const int shapePetal = 2;
  static const int shapeStar = 3;
  static const int shapeSpark = 4;

  Particle({
    required this.x,
    required this.y,
    this.vx = 0,
    this.vy = 0,
    this.ax = 0,
    this.ay = 0,
    this.life = 1.0,
    this.maxLife = 1.0,
    this.size = 3.0,
    this.color = const Color(0xFFFFFFFF),
    this.trail = const [],
    this.rotation = 0,
    this.rotationSpeed = 0,
    this.shape = shapeCircle,
  });

  double get progress => 1.0 - (life / maxLife);
  bool get isAlive => life > 0;

  void update(double dt) {
    trail.add(Offset(x, y));
    if (trail.length > 6) trail.removeAt(0);

    vx += ax * dt;
    vy += ay * dt;
    x += vx * dt;
    y += vy * dt;
    life -= dt;
    rotation += rotationSpeed * dt;
  }

  void draw(Canvas canvas, Paint paint, {BlendMode blendMode = BlendMode.srcOver}) {
    final alpha = (life / maxLife).clamp(0.0, 1.0);
    paint.blendMode = blendMode;

    if (trail.length > 1) {
      for (int i = 0; i < trail.length - 1; i++) {
        final trailAlpha = alpha * (i / trail.length) * 0.5;
        paint.color = color.withOpacity(trailAlpha);
        canvas.drawCircle(trail[i], size * 0.5 * (i / trail.length), paint);
      }
    }

    paint.color = color.withOpacity(alpha);

    switch (shape) {
      case shapeDiamond:
        _drawDiamond(canvas, paint, size);
        break;
      case shapePetal:
        _drawPetal(canvas, paint, size);
        break;
      case shapeStar:
        _drawStar(canvas, paint, size);
        break;
      case shapeSpark:
        _drawSpark(canvas, paint, size, alpha);
        break;
      default:
        canvas.drawCircle(Offset(x, y), size, paint);
        paint.color = color.withOpacity(alpha * 0.3);
        canvas.drawCircle(Offset(x, y), size * 2.5, paint);
    }
  }

  void _drawDiamond(Canvas canvas, Paint paint, double s) {
    final path = Path()
      ..moveTo(x, y - s)
      ..lineTo(x + s * 0.7, y)
      ..lineTo(x, y + s)
      ..lineTo(x - s * 0.7, y)
      ..close();
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(rotation);
    canvas.translate(-x, -y);
    canvas.drawPath(path, paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 0.5;
    paint.color = paint.color.withOpacity(paint.color.opacity * 0.5);
    canvas.drawLine(Offset(x - s * 0.7, y), Offset(x + s * 0.7, y), paint);
    canvas.drawLine(Offset(x, y - s), Offset(x, y + s), paint);
    paint.style = PaintingStyle.fill;
    canvas.restore();
  }

  void _drawPetal(Canvas canvas, Paint paint, double s) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(rotation);
    final path = Path();
    path.moveTo(0, -s * 1.5);
    path.quadraticBezierTo(s, -s * 0.5, 0, s * 1.5);
    path.quadraticBezierTo(-s, -s * 0.5, 0, -s * 1.5);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawStar(Canvas canvas, Paint paint, double s) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(rotation);
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final outerAngle = -math.pi / 2 + i * 2 * math.pi / 5;
      final innerAngle = outerAngle + math.pi / 5;
      if (i == 0) {
        path.moveTo(math.cos(outerAngle) * s, math.sin(outerAngle) * s);
      }
      path.lineTo(math.cos(innerAngle) * s * 0.4, math.sin(innerAngle) * s * 0.4);
      path.lineTo(math.cos(outerAngle + 2 * math.pi / 5) * s, math.sin(outerAngle + 2 * math.pi / 5) * s);
    }
    path.close();
    canvas.drawPath(path, paint);
    paint.color = paint.color.withOpacity(paint.color.opacity * 0.4);
    canvas.drawCircle(Offset.zero, s * 1.5, paint);
    canvas.restore();
  }

  void _drawSpark(Canvas canvas, Paint paint, double s, double alpha) {
    final len = s * 3 * alpha;
    paint.strokeWidth = s * 0.3;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(x - len, y), Offset(x + len, y), paint);
    canvas.drawLine(Offset(x, y - len), Offset(x, y + len), paint);
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(x, y), s * 0.6, paint);
  }
}
