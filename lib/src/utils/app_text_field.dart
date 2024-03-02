import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infotexh_test/src/constants/colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.hint,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.defaultText,
    this.controller,
    this.maxLines,
    this.formatter,
    this.width,
    this.errorText,
    this.onTap,
  }) : super(key: key);

  final String hint;
  final double? width;
  final String? defaultText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String val)? onChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? formatter;
  final String? errorText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController controller = TextEditingController();
  bool obscureText = false;
  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      controller = widget.controller!;
    }
    obscureText = widget.obscureText;
    if (widget.defaultText != null) {
      controller.text = widget.defaultText!;
    }
  }

  void toggleVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        onTap: widget.onTap,
        inputFormatters: widget.formatter,
        style: const TextStyle(
          fontSize: 15,
        ),
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        keyboardType: widget.keyboardType,
        obscureText: obscureText,
        maxLines: obscureText ? 1 : widget.maxLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          errorText: widget.errorText,
          filled: true,
          fillColor: AppColors.textFieldColor,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: widget.hint,
          hintStyle: const TextStyle(
            color: AppColors.lightTextColor,
          ),
        ),
      ),
    );
  }
}
