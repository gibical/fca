import 'dart:async';

import 'package:flutter/material.dart';


class BlinkingIcon extends StatefulWidget {
  @override
  _BlinkingIconState createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<BlinkingIcon> {
  double _opacity = 1.0;
  Timer? _timer;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _opacity = _isVisible ? 0.4 : 1.0;
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 900),
        child: Icon(Icons.play_arrow)
    );
  }
}