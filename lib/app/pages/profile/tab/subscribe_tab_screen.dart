import 'package:flutter/material.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_tab_bar_widget.dart';


class SubscribeTabScreen extends StatelessWidget {
  const SubscribeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBarWidget(),
    );
  }
}
