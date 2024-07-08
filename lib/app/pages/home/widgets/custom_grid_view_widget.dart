import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomGridViewWidget extends StatelessWidget {
  const CustomGridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return     SliverGrid.builder(
        itemCount: 9,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(10.sp),

            ),
          );
        });
  }
}
