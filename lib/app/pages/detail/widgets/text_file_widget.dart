import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;

class DownloadDisplayText extends StatefulWidget {
  final String url;
  final TextStyle style;

  DownloadDisplayText({Key? key, required this.url, required this.style}) : super(key: key);

  @override
  _DownloadDisplayTextState createState() => _DownloadDisplayTextState();
}

class _DownloadDisplayTextState extends State<DownloadDisplayText> {
  late Future<String> _fileContent;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _fileContent = downloadFile(widget.url);
  }

  Future<String> downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return utf8.decode(response.bodyBytes);
      } else {
        return 'details_16'.tr;
      }
    } catch (e) {
      return 'details_17'.tr +'${e.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fileContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child:Container());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SingleChildScrollView(
           // padding: EdgeInsets.all(16.0),
            child: GestureDetector(
                onTap: (){
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },child: Text(
               ( snapshot.data == null
                    ? ''
                    : isExpanded
                    ?   snapshot.data
                    :   snapshot.data.toString().length > 80
                    ?   snapshot.data.toString()
                    .substring(0, 80) +
                    '...more'
                    :  snapshot.data)??""
                , style: widget.style)),
          );
        }
      },
    );
  }
}
