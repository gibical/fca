import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/wallet/widget/billing/not_connected.dart';
import 'package:mediaverse/app/pages/wallet/widget/income/income_widget.dart';
import 'package:mediaverse/app/pages/wallet/widget/invoice/invoice_widget.dart';
import 'package:mediaverse/app/pages/wallet/widget/package/package_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/profile/logic.dart';
import 'package:mediaverse/app/pages/transactions/view.dart';
import 'package:mediaverse/app/pages/wallet/logic.dart';
import 'package:sizer/sizer.dart';

import '../wrapper/logic.dart';


class WalletScreen extends StatefulWidget {

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>   with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  ProfileControllers logic = Get.find<HomeLogic>().profileController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        toolbarHeight: 10,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(right: 10.w),
          child: Column(
            children: [


            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60.sp),
                  bottomLeft: Radius.circular(60.sp),
                ),
              ),
              height: 60,
              child: TabBar(
                tabAlignment: TabAlignment.center,
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                enableFeedback: false,
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColor.primaryLightColor,
                unselectedLabelColor: Colors.grey,
                labelColor: AppColor.primaryLightColor,
                dividerColor: Colors.transparent,
                tabs: [
                  _buildTab(context, 0, 'channel_36'.tr),
                  _buildTab(context, 1, 'channel_37'.tr),
                  _buildTab(context, 2, 'channel_38'.tr),
                  _buildTab(context, 3, 'channel_39'.tr),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  BillingWidget(logic),
                  InvoiceWidget(logic),
                  IncomeWidget(logic),
                  PackageWidget(logic),//
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, int tabIndex, String label) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(label)],
      ),
    );
  }



}
