import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator; // ✅ Added Validator Support
  final IconData? prefixIcon;
  final String? prefixText; // ✅ Added Prefix Text Support (For Phone Numbers)
  final Widget? suffixIcon; // ✅ Changed to Widget? for better flexibility
  final VoidCallback? onSuffixTap;
  final Color? fillColor;
  final bool isFilled;
  final double borderRadius;
  final bool isEnabled;
  final int? maxLength;
  final int? maxLines;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.prefixIcon,
    this.prefixText, // ✅ Fixed Prefix Text Support
    this.suffixIcon,
    this.onSuffixTap,
    this.fillColor,
    this.isFilled = false,
    this.borderRadius = 10.0,
    this.isEnabled = true,
    this.maxLength,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// **Label**
        Text(
          widget.label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),

        /// **Text Field**
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          obscureText: _obscureText,
          enabled: widget.isEnabled,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          validator: widget.validator, // ✅ Added Validator Handling
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: widget.isFilled,
            fillColor: widget.fillColor ?? Colors.grey[200],

            /// **Prefix Handling**
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            prefixText: widget.prefixText, // ✅ Fixed Prefix Text Support
            prefixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

            /// **Suffix Handling**
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            )
                : widget.suffixIcon, // ✅ Now directly supports widgets

            /// **Border Styling**
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            counterText: '',
          ),
        ),
      ],
    );
  }
}
