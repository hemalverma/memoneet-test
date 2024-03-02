import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  // shows success message snack bar
  static void showSuccessMessage(
    BuildContext context,
    String message, {
    double? bottomMargin,
  }) =>
      _showSnackBar(
        context,
        message,
        Colors.green,
        bottomMargin: bottomMargin,
      );

  /// shows error message snack bar
  static void showErrorMessage(
    BuildContext context,
    String message, {
    double? bottomMargin,
  }) =>
      _showSnackBar(
        context,
        message,
        const Color(0xFFFF3F3F),
        bottomMargin: bottomMargin,
      );

  static void _showSnackBar(
    BuildContext context,
    String message,
    Color highlightColor, {
    double? bottomMargin,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // remove current SnackBar, if any
    scaffoldMessenger.removeCurrentSnackBar();
    // show the snack bar
    scaffoldMessenger.showSnackBar(
      SnackBar(
        margin: EdgeInsets.fromLTRB(
          15.0,
          5.0,
          15.0,
          bottomMargin ?? 10.0,
        ),
        content: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: highlightColor,
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFFFCFCFC),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.cancel,
                    size: 20,
                    color: Color(0xFFDADADA),
                  ),
                  onPressed: () => scaffoldMessenger.hideCurrentSnackBar(),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xFF323232),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        duration: const Duration(
          milliseconds: 1500,
        ),
      ),
    );
  }
}
