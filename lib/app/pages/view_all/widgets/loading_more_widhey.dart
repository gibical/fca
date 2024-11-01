
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LoadigMorewidget extends StatefulWidget {
  Function function;

  String keys;

  LoadigMorewidget({required this.keys, required this.function});

  @override
  State<LoadigMorewidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<LoadigMorewidget> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {




    return VisibilityDetector(
      key: Key(widget.keys),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;

        if(visiblePercentage>50){
         widget.function.call();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("viewall_6".tr, style: TextStyle(
                fontWeight: FontWeight.bold),),
            SizedBox(width: 10,),
            SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(

              ),
            )
          ],
        ),
      ),
    );
  }


  @override
  void initState() {

  }
}
