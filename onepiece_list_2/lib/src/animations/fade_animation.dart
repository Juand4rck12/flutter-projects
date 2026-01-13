import 'package:flutter/material.dart';

/// Un widget personalizado que aplica una animación de desvanecimiento (fade)
/// a su widget hijo usando [TweenAnimationBuilder].
class FadeAnimation extends StatelessWidget {
  const FadeAnimation({
    super.key,
    required this.child,
    this.begin = 0, // Opacidad inicial (0 = completamente transparente)
    this.end = 1, // Opacidad final (1 = completamente opaco)
    this.intervalStart = 0, // Inicio del intervalo de la animación (0 = inicio)
    this.intervalEnd = 1, // Fin del intervalo de la animación (1 = final)
    this.duration = const Duration(
      milliseconds: 3000,
    ), // Duración de la animación
    this.curve =
        Curves.fastOutSlowIn, // Curva de animación para suavizar el efecto
  });

  final double begin;
  final double end;
  final Duration duration;
  final double intervalStart;
  final double intervalEnd;
  final Curve curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // TweenAnimationBuilder permite animar el valor de opacidad de 'begin' a 'end'
    // durante el tiempo especificado en 'duration' y usando la curva y el intervalo dados.
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: begin, end: end),
      duration: duration,
      // Interval permite controlar en qué parte de la duración total ocurre la animación
      curve: Interval(intervalStart, intervalEnd, curve: curve),
      child: child,
      // El builder actualiza la opacidad del widget hijo según el valor animado
      builder: (BuildContext context, double? value, Widget? child) {
        return Opacity(opacity: value!, child: child);
      },
    );
  }
}
