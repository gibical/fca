import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../gen/model/json/FromJsonGetNewCountries.dart';
import '../common/app_color.dart';

class CountryPickerBottomSheet extends StatefulWidget {

  List<CountryModel> model;



  CountryPickerBottomSheet(this.model);

  @override
  State<CountryPickerBottomSheet> createState() => _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  String text = "";
  TextEditingController _searchController = TextEditingController();
  List<CountryModel> filteredCountries = [];

  @override
  void initState() {
    super.initState();
    filteredCountries = widget.model;

    _searchController.addListener(() {
      setState(() {
        text = _searchController.text;
        filteredCountries = widget.model.where((country) {
          return country.name.toString().toLowerCase().contains(text.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 50.h,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryLightColor),
        borderRadius: BorderRadius.circular(10),
        color: "000033".toColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              "viewall_2".tr,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 6.h,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primaryLightColor),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search...",
                  hintStyle: TextStyle(
                    color: AppColor.primaryLightColor.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, i) {
                CountryModel index = filteredCountries[i];
                return MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () {
                    Get.back(result: index);
                  },
                  child: Container(
                    width: 100.w,
                    height: 4.h,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        ClipRRect(
                          child: CountryFlag.fromCountryCode(
                            index.iso.toString(),
                            height: 2.h,
                            width: 6.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  index.name.toString(),
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "  -  ${index.iso}",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LangaugePickerBottomSheet extends StatefulWidget {

  Map<String, dynamic> model;



  LangaugePickerBottomSheet(this.model);

  @override
  State<LangaugePickerBottomSheet> createState() => _LangaugePickerBottomSheetState();
}

class _LangaugePickerBottomSheetState extends State<LangaugePickerBottomSheet> {
  String text = "";
  TextEditingController _searchController = TextEditingController();
  Map<String, dynamic> filteredCountries = {};

  @override
  void initState() {
    super.initState();
    filteredCountries = widget.model;

    _searchController.addListener(() {
      setState(() {
        text = _searchController.text;
        filteredCountries = Map.fromEntries(
          widget.model.entries.where((entry) {
            return entry.value
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase());
          }),
        );
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 50.h,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryLightColor),
        borderRadius: BorderRadius.circular(10),
        color: "000033".toColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              "viewall_2".tr,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 6.h,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primaryLightColor),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search...",
                  hintStyle: TextStyle(
                    color: AppColor.primaryLightColor.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.values.length,
              itemBuilder: (context, i) {
                return MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () {
                    Get.back(result: filteredCountries.keys.elementAt(i));
                  },
                  child: Container(
                    width: 100.w,
                    height: 4.h,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [

                        SizedBox(width: 3.w),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  filteredCountries.values.elementAt(i),
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "  -  ${filteredCountries.keys.elementAt(i)}",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}