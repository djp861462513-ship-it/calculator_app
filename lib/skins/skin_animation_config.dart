import 'dart:ui';
import 'package:flutter/material.dart';

enum AnimationType {
  none,
  rotatingGradient,
  flowingParticles,
  pulsingGlow,
  shimmerWave,
  starfield,
  aurora,
  floatingOrbs,
  rainbowShift,
  fireworks,
  cherryBlossom,
  oceanBubbles,
  constellation,
  diamondSparkle,
  neonStream,
}

class SkinAnimationConfig {
  final AnimationType type;
  final Duration duration;
  final List<Color> particleColors;
  final double intensity;
  final BlendMode blendMode;

  const SkinAnimationConfig({
    this.type = AnimationType.none,
    this.duration = const Duration(seconds: 8),
    this.particleColors = const [],
    this.intensity = 1.0,
    this.blendMode = BlendMode.srcOver,
  });

  static const none = SkinAnimationConfig(type: AnimationType.none);

  bool get hasAnimation => type != AnimationType.none;

  static const aurora = SkinAnimationConfig(
    type: AnimationType.aurora,
    duration: Duration(seconds: 12),
    particleColors: [Color(0xFF00FF87), Color(0xFF60EFFD), Color(0xFF0099F7), Color(0xFFA06CD4)],
    intensity: 0.8,
  );

  static const starfield = SkinAnimationConfig(
    type: AnimationType.starfield,
    duration: Duration(seconds: 20),
    particleColors: [Color(0xFFFFFFFF), Color(0xFFB0C4DE), Color(0xFFE6E6FA), Color(0xFFFFD700)],
    intensity: 0.6,
  );

  static const lava = SkinAnimationConfig(
    type: AnimationType.pulsingGlow,
    duration: Duration(seconds: 5),
    particleColors: [Color(0xFFFF4500), Color(0xFFFF6B00), Color(0xFFFFD700)],
    intensity: 0.7,
  );

  static const inkWash = SkinAnimationConfig(
    type: AnimationType.flowingParticles,
    duration: Duration(seconds: 15),
    particleColors: [Color(0x15000000), Color(0x10000000)],
    intensity: 0.3,
  );

  static const rainbow = SkinAnimationConfig(
    type: AnimationType.rainbowShift,
    duration: Duration(seconds: 6),
    particleColors: [Color(0xFFFF0000), Color(0xFFFF7F00), Color(0xFFFFFF00), Color(0xFF00FF00), Color(0xFF00BFFF), Color(0xFF4B0082), Color(0xFF9400D3)],
    intensity: 1.0,
  );

  static const blackGold = SkinAnimationConfig(
    type: AnimationType.shimmerWave,
    duration: Duration(seconds: 4),
    particleColors: [Color(0xFFFFD700), Color(0xFFDAA520), Color(0xFFFFC125)],
    intensity: 0.6,
  );

  static const dopamineShimmer = SkinAnimationConfig(
    type: AnimationType.shimmerWave,
    duration: Duration(seconds: 7),
    particleColors: [Color(0xFFFF6B6B), Color(0xFFFFEAA7), Color(0xFF0984E3)],
    intensity: 0.3,
  );

  static const natureFloat = SkinAnimationConfig(
    type: AnimationType.floatingOrbs,
    duration: Duration(seconds: 14),
    particleColors: [Color(0xFFAED8B0), Color(0xFFD4A76A), Color(0xFF6B8F71)],
    intensity: 0.2,
  );

  static const morandiShimmer = SkinAnimationConfig(
    type: AnimationType.shimmerWave,
    duration: Duration(seconds: 10),
    particleColors: [Color(0xFFB8A9C9), Color(0xFFE8D5C4), Color(0xFFD5E8D4)],
    intensity: 0.15,
  );

  static const cyberpunkGlow = SkinAnimationConfig(
    type: AnimationType.pulsingGlow,
    duration: Duration(seconds: 3),
    particleColors: [Color(0xFF00F5FF), Color(0xFFFF007F), Color(0xFF7B68EE)],
    intensity: 0.5,
  );

  static const fireworksNight = SkinAnimationConfig(
    type: AnimationType.fireworks,
    duration: Duration(seconds: 30),
    particleColors: [
      Color(0xFFFF1744), Color(0xFFFFD700), Color(0xFF00E5FF),
      Color(0xFF76FF03), Color(0xFFE040FB), Color(0xFFFF6E40),
      Color(0xFFFFFFFF), Color(0xFFFFC400),
    ],
    intensity: 1.0,
    blendMode: BlendMode.plus,
  );

  static const cherryBlossom = SkinAnimationConfig(
    type: AnimationType.cherryBlossom,
    duration: Duration(seconds: 20),
    particleColors: [
      Color(0xFFFFB7C5), Color(0xFFFFC1CC), Color(0xFFFFE0EC),
      Color(0xFFE6A0C9), Color(0xFFFFFFFF), Color(0xFFFFD1DC),
    ],
    intensity: 0.8,
  );

  static const ocean = SkinAnimationConfig(
    type: AnimationType.oceanBubbles,
    duration: Duration(seconds: 15),
    particleColors: [
      Color(0xFF40C4FF), Color(0xFF80D8FF), Color(0xFFB2EBF2),
      Color(0xFF18FFFF), Color(0xFF00E5FF), Color(0xAA64FFDA),
    ],
    intensity: 0.7,
    blendMode: BlendMode.plus,
  );

  static const constellation = SkinAnimationConfig(
    type: AnimationType.constellation,
    duration: Duration(seconds: 25),
    particleColors: [
      Color(0xFFE6C0FF), Color(0xFFFFD700), Color(0xFF00BFFF),
      Color(0xFFFFFFFF), Color(0xFFB8860B),
    ],
    intensity: 0.8,
    blendMode: BlendMode.plus,
  );

  static const diamondSparkle = SkinAnimationConfig(
    type: AnimationType.diamondSparkle,
    duration: Duration(seconds: 10),
    particleColors: [
      Color(0xFFFFFFFF), Color(0xFFE1F5FE), Color(0xFFB3E5FC),
      Color(0xFFE0F7FA), Color(0xFF80DEEA), Color(0xFFFFFFFF),
    ],
    intensity: 0.8,
    blendMode: BlendMode.plus,
  );

  static const neonStream = SkinAnimationConfig(
    type: AnimationType.neonStream,
    duration: Duration(seconds: 8),
    particleColors: [
      Color(0xFF00E5FF), Color(0xFFD500F9), Color(0xFF6200EA),
      Color(0xFF00BFA5), Color(0xFFFFD600),
    ],
    intensity: 0.9,
    blendMode: BlendMode.plus,
  );
}
