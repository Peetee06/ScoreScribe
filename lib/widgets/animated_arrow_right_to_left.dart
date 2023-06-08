import 'package:flutter/material.dart';

class AnimatedArrowLeftToRight extends StatefulWidget {
  const AnimatedArrowLeftToRight({super.key});

  @override
  State<AnimatedArrowLeftToRight> createState() =>
      _AnimatedArrowLeftToRightState();
}

class _AnimatedArrowLeftToRightState extends State<AnimatedArrowLeftToRight>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 15, end: -10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return // You can adjust this
        Transform.translate(
      offset: Offset(_animation.value, 0),
      child: RotatedBox(
        quarterTurns: 1,
        child: Icon(
          Icons.arrow_downward,
          size: 36,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ), // adjust the size as needed
    );
  }
}
