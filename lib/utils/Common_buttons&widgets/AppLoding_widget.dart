import 'package:flutter/material.dart';

import '../../app/configuration/themes/app_colors.dart';
class CustomLoader extends StatefulWidget {
  const CustomLoader({super.key});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          // color: Colors.grey.shade300,
          color: AppColors.primary.withOpacity(0.7),

          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Loading...',
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
