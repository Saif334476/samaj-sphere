import 'package:flutter/material.dart';

class BouncingDots extends StatefulWidget {
 final Color? color;

  const BouncingDots({super.key,this.color,});

  @override
  BouncingDotsState createState() => BouncingDotsState();
}

class BouncingDotsState extends State<BouncingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late Animation<double> _animation4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..repeat(reverse: true);

    _animation1 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _animation2 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeInOut)),
    );

    _animation3 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeInOut)),
    );
    _animation4 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0, curve: Curves.easeInOut)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedBuilder(
            animation: _animation1,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation1.value),
                child: Dot(color: widget.color,),
              );
            },
          ),
          AnimatedBuilder(
            animation: _animation2,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation2.value),
                child: Dot(color: widget.color,),
              );
            },
          ),
          AnimatedBuilder(
            animation: _animation3,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation3.value),
                child: Dot(color: widget.color,),
              );
            },
          ),
          AnimatedBuilder(
            animation: _animation4,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation3.value),
                child:  Dot(color:widget.color),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final Color? color;
  const Dot({super.key,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 12,
      decoration: BoxDecoration(
        color: color ?? const Color(0xFF2074B5),
        shape: BoxShape.circle,
      ),
    );
  }
}
