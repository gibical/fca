


import 'package:flutter/material.dart';


class AnimationTextFieldWidget extends StatefulWidget {
  const AnimationTextFieldWidget({super.key , required this.child});


  final Widget child;
  @override
  State<AnimationTextFieldWidget> createState() => _AnimationTextFieldWidgetState();
}

class _AnimationTextFieldWidgetState extends State<AnimationTextFieldWidget> with SingleTickerProviderStateMixin {


  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: Duration(
          milliseconds: 600
      ),
      vsync: this,

    );

    _animation = Tween<Offset>(end: Offset(0, 0), begin: Offset(0, 1)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(position:  _animation , child: widget.child,);
  }
}
