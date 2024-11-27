import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/app_color.dart';

class CustomTextFieldRegisterWidget extends StatefulWidget {
  final String hintText;
  final String titleText;
  final bool needful;
  final TextEditingController? textEditingController;
  final bool showCursor;
  final BuildContext context;
  final bool isPassword;

  CustomTextFieldRegisterWidget({
    required this.hintText,
    required this.titleText,
    required this.context,
    required this.needful,
    this.textEditingController,
    this.showCursor = false,
    this.isPassword = false,
  });

  @override
  _CustomTextFieldRegisterState createState() => _CustomTextFieldRegisterState();
}

class _CustomTextFieldRegisterState extends State<CustomTextFieldRegisterWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: SizedBox(
        height: 53,
        child: TextFormField(
          controller: widget.textEditingController ?? TextEditingController(),
          showCursor: widget.showCursor,
          obscureText: widget.isPassword ? _obscureText : false,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white, // Replace with AppColor.whiteColor if defined
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.75), // Replace with AppColor.whiteColor if defined
            ),
            prefixIcon: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25, left: 10),
                  child: Text(
                    widget.titleText,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.75), // Replace with AppColor.whiteColor if defined
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  child: Container(
                    height: 28,
                    width: 1.5,
                    color: Color(0xff4E4E61).withOpacity(0.9),
                  ),
                ),
              ],
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColor.primaryLightColor, // Adjust icon color as needed
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
            fillColor: Color(0xff0E0E12).withOpacity(0.5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9.0), // Adjust as needed
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}