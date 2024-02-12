import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';


class CalendarTabScreen extends StatelessWidget {
  const CalendarTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverAppBar(

            shape: RoundedRectangleBorder(
              
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)
              )
            ),
          ),
          SliverToBoxAdapter(),
        ],
      ),
    );
  }
}

