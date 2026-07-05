import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';

class TextformView extends StatefulWidget {
  const TextformView({
    super.key,
    required this.isPassword,
    required this.hint,
    required this.controller,
    this.colorbackground,
    this.colortextinput,
    this.colortexthint,
    this.colorborder,
    this.colorIcon,
    this.textInputType,
  });

  final bool isPassword;
  final String hint;
  final TextEditingController controller;
  final Color? colorbackground;
  final Color? colortextinput;
  final Color? colortexthint;
  final Color? colorborder;
  final Color? colorIcon;
  final TextInputType? textInputType;

  @override
  State<TextformView> createState() => _TextformViewState();
}

class _TextformViewState extends State<TextformView> {
  late bool _obscureText;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      cursorHeight: 25,
      cursorColor: Appcolors.background,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.hint}';
        }
        return null;
      },
      controller: widget.controller,
      style: Textstyle.text16bold.copyWith(
        color: widget.colortextinput ?? Appcolors.background,
        fontWeight: FontWeight.normal,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.colorbackground ?? Appcolors.white,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggleObscureText,
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: widget.colorIcon ?? Appcolors.background,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color:
                widget.colorborder ?? Appcolors.black.withValues(alpha: 0.08),
            width: 1.5,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: widget.colorborder ?? Appcolors.background,
            width: 1.5,
          ),
        ),
        hintText: widget.hint,
        hintStyle: Textstyle.text14bold.copyWith(
          color:
              widget.colortexthint ?? Appcolors.textHint.withValues(alpha: 0.7),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
