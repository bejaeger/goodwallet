import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class GreySearchTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onSuffixIconPressed;
  final void Function()? onTap;
  final TextEditingController? controller;

  final String hintText;
  final bool autofocus;

  const GreySearchTextField({
    Key? key,
    this.focusNode,
    this.onChanged,
    this.hintText = "Search",
    this.autofocus = false,
    this.onSuffixIconPressed,
    this.onTap,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textFieldFocusNode = focusNode ?? FocusNode();
    return Align(
      child: Container(
        width: screenWidth(context) - LayoutSettings.horizontalPadding * 2,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorSettings.textFieldBackground,
        ),
        child: TextField(
          controller: controller,
          onTap: onTap,
          autofocus: autofocus,
          textAlignVertical: TextAlignVertical.center,
          focusNode: textFieldFocusNode,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textTheme(context)
                  .bodyText2!
                  .copyWith(fontSize: 16, color: Colors.grey[400]),
              contentPadding: EdgeInsets.only(bottom: 10),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
              suffixIcon: onSuffixIconPressed != null
                  // workaround otherwise text field will be focused
                  ? GestureDetector(
                      child:
                          Icon(Icons.qr_code_scanner, color: Colors.grey[800]),
                      onTap: () {
                        // Unfocus all focus nodes
                        textFieldFocusNode.unfocus();
                        // // Disable text field's focus node request
                        textFieldFocusNode.canRequestFocus = false;
                        onSuffixIconPressed!();
                        //Enable the text field's focus node request after some delay
                        Future.delayed(Duration(milliseconds: 100), () {
                          textFieldFocusNode.canRequestFocus = true;
                        });
                      })
                  : null),
          style: textTheme(context)
              .bodyText2!
              .copyWith(fontSize: 16, color: Colors.grey[550]),
          cursorColor: Colors.grey[400],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
