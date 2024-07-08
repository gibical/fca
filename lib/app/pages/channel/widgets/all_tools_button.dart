import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class AllToolsButtonWidget extends StatefulWidget {

  Function onPressed ;
  String icon;
  String name;
  bool enable;
  @override
  State<AllToolsButtonWidget> createState() => _AllToolsButtonWidgetState();

  AllToolsButtonWidget({required this.onPressed, required this.icon, required this.name, this.enable=true});
}

class _AllToolsButtonWidgetState extends State<AllToolsButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:16),
      child: Opacity(
        opacity: widget.enable?1:0.4,
        child: Container(
          margin: EdgeInsets.only(bottom: 2.h),
          width: double.infinity,
          height: 9.h,
          child: MaterialButton(
            enableFeedback: false,

            onPressed: (){
              widget.onPressed.call();
              },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [


                Container(
                  width: 6.h,
                  height: 6.h,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Image.asset("assets/images/all_tools_icon_bg.png"),
                      ),
                      Align(
                        child: SvgPicture.asset(widget.icon),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 4.w,),
                Text(widget.name,style: TextStyle(color: Colors.white),)

              ],
            ),
          ),
          decoration: BoxDecoration(
              color: Color(0xff4E4E61).withOpacity(0.3),
              borderRadius: BorderRadius.circular(16.sp),
              border: Border(
                top: BorderSide(color: Colors.grey.withOpacity(0.4) , width: 0.9),
                left: BorderSide(color: Colors.grey.withOpacity(0.4) , width: 0.5),
              )
          ),
        ),
      ),

    );
  }
}
