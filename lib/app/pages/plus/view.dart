import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/plus/widgets/perimisson_bottom_sheet.dart';

import 'logic.dart';
import 'state.dart';

class PlusPage extends StatefulWidget {
  PlusPage({Key? key}) : super(key: key);

  @override
  State<PlusPage> createState() => _PlusPageState();
}

class _PlusPageState extends State<PlusPage> {
  final PlusLogic logic = Get.put(PlusLogic());

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
