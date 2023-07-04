import 'package:flutter/material.dart';

class Magnet extends StatelessWidget {
  const Magnet({super.key, this.onPanUpdate, required this.top, required this.left, this.onPanDown, required this.color, this.magnetKey});

  final Function(DragUpdateDetails)? onPanUpdate;
  final Function(DragDownDetails)? onPanDown;

  final GlobalKey? magnetKey;

  final double left;
  final double top;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: left,
              top: top,
              child: GestureDetector(
                key: magnetKey,
                onPanDown: (d) {
                 onPanDown!(d);
                },
                onPanUpdate: (details) {
                  onPanUpdate!(details);
                },
                onPanEnd: (details) {},
                child:  SizedBox(
                  width: 100,
                  height: 100,
                  child: Card(
                    elevation: 5.0,
                    
                    color: color,
                  ),
                ),
              ),
            );
  }
}