import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';

class OutPutWidget extends StatelessWidget {
  const OutPutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: 100.w,
          child: Image.asset("assets/${F.assetTitle}/images/all_tools_bg.png",fit: BoxFit.cover,)),
    );
  }
}
