import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memoneet_test/src/constants/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.textSize = 17,
    required this.isProcessing,
    required this.buttonColor,
    required this.onClicked,
    this.buttonWidth,
    this.buttonHeight,
    this.isDisabled = false,
    this.buttonPadding = const EdgeInsets.all(12),
    this.radius = 25,
  });

  final VoidCallback? onClicked;

  final String text;
  final double textSize;
  final double? buttonHeight;
  final EdgeInsetsGeometry buttonPadding;
  final double? buttonWidth;
  final Color buttonColor;
  final bool isProcessing;
  final bool isDisabled;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: buttonHeight,
      padding: EdgeInsets.zero,
      onPressed: (isDisabled)
          ? null
          : (!isProcessing)
              ? onClicked
              : null,
      child: Container(
        padding: buttonPadding,
        height: buttonHeight,
        width: buttonWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (isDisabled)
              ? AppColors.primaryColor.withOpacity(0.5)
              : (!isProcessing)
                  ? buttonColor
                  : Colors.black38,
          boxShadow: const [
            BoxShadow(
              color: AppColors.primaryColor,
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(4, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: AppColors.darkTextColor,
            width: 0.2,
          ),
        ),
        child: (isProcessing)
            ? Center(
                child: SizedBox(
                  height: buttonPadding == EdgeInsets.zero ? 5 : 20,
                  width: buttonPadding == EdgeInsets.zero ? 5 : 20,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: buttonPadding == EdgeInsets.zero ? 1 : 3,
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: (isDisabled)
                      ? AppColors.darkTextColor.withOpacity(0.7)
                      : AppColors.darkTextColor,
                  fontSize: textSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
