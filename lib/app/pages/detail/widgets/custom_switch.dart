import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/app_extension.dart';


class CustomSwitchWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchWidget({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchWidgetState createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: "9c9cb8".toColor(),
        value: widget.value,
        onChanged: (s) {
          widget.onChanged(!widget.value);          });
  }
}