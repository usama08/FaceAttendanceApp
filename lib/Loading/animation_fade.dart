import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final double delay;
  final double opacity;
  final double xOffset;
  final Widget child;

  const FadeAnimation({super.key, 
    required this.delay,
    this.opacity = 1.0,
    this.xOffset = 0.0,
    required this.child,
  });

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> {
  double _opacity = 0.0;
  double _xOffset = 100.0; // Initial xOffset value
  bool _animationCompleted = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()), () {
      if (mounted) {
        setState(() {
          _opacity = widget.opacity;
          _xOffset = 0.0; // Update the xOffset to 0 for the final position
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(
          milliseconds: (widget.delay * 1500)
              .round()), // Adjust duration for a slower fade-in
      curve: Curves.easeOut,
      child: Transform.translate(
        offset: Offset(_xOffset, 0.0),
        child: widget.child,
      ),
      onEnd: () {
        if (mounted && !_animationCompleted) {
          setState(() {
            _animationCompleted = true;
          });
        }
      },
    );
  }
}
