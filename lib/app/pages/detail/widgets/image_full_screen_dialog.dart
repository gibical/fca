import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:widget_zoom/widget_zoom.dart';

class FullScreenDialogWidget extends StatelessWidget {

  String imageURL;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: RotatedBox(
        quarterTurns: 1,
        child: Container(
          child:  PinchZoom(
            child: Image.network(

              imageURL
            ),
          ),
        ),
      ),
    );
  }

  FullScreenDialogWidget(this.imageURL);
}
