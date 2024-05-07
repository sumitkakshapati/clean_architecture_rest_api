import 'package:flutter/material.dart';

class TapEffect extends StatefulWidget {
  final Widget child;
  final double scaleDown;
  final bool enable;
  const TapEffect({
    super.key,
    required this.child,
    this.scaleDown = 0.9,
    this.enable = true,
  });

  @override
  State<TapEffect> createState() => _TapEffectState();
}

class _TapEffectState extends State<TapEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 80));
    final tween = Tween<double>(begin: 1, end: widget.scaleDown);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn)
            .drive(tween);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        if (widget.enable) _animationController.reverse();
      },
      onTapCancel: () {
        if (widget.enable) _animationController.reverse();
      },
      onTapDown: (details) {
        if (widget.enable) _animationController.forward();
      },
      child: ScaleTransition(
        scale: _animation,
        child: widget.child,
      ),
    );
  }
}
