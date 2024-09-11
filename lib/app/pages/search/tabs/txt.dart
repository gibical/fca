import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TxtWidget extends StatelessWidget {
  TxtWidget({super.key, required this.model});
  dynamic model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 40.w,
          height: 20.w,
          decoration: const BoxDecoration(
              // color: theme.onBackground.withOpacity(0.1),
              // border: Border.symmetric(horizontal: BorderSide(
              //   width: 0.9,
              //   color: theme.onBackground.withOpacity(0.2 , ),
              // )),
              // borderRadius: BorderRadius.all(Radius.circular(20.sp))
              ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              SizedBox.expand(
                child: Image.asset(
                  "assets/images/text_bg.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox.expand(
                child: Container(
                    padding: EdgeInsets.all(5.w),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            model['media']['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                              color: const Color(0xFFCCCCFF),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            model['description'] ?? " ",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF666680),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/avatar.jpeg",
                              width: 4.w,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              model['asset']['user']['username'] ?? " ",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF666680),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              )
            ],
          )),
    );
  }
}
