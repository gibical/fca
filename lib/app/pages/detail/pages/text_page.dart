import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../common/app_color.dart';
import '../../../common/widgets/appbar_btn.dart';

class TextPage extends StatefulWidget {
  final String title;
  final String url;

  const TextPage({super.key, required this.title, required this.url});

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  late Future<String> _textFuture;

  @override
  void initState() {
    super.initState();
    _textFuture = _loadTextFromUrl(widget.url);
  }

  Future<String> _loadTextFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return utf8.decode(response.bodyBytes); 
      } else {
        throw Exception('Failed to load text: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading text: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryDark,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              toolbarHeight: 10.h,
              surfaceTintColor: Colors.transparent,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppbarBTNWidget(
                          iconName: 'back1',
                          onTap: () {
                            Get.back();
                          }),
                      Spacer(),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            widget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: AppColor.secondaryDark,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 1.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: FutureBuilder<String>(
                  future: _textFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Transform.scale(
                          scale: 0.5,
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                            backgroundColor: AppColor.primaryColor.withOpacity(0.3),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      );
                    } else {
                      return Text(
                        snapshot.data ?? '',
                        style: TextStyle(
                          color: '9C9CB8'.toColor(),
                          height: 2,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
