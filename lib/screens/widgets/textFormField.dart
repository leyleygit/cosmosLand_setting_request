import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  const CustomTextFormField({
    Key? key,
    this.focusNode,
    this.hintText,
    this.validator,
    this.maxLines,
    this.controller,
    this.textInputType,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType ?? TextInputType.text,
      controller: widget.controller ?? TextEditingController(),
      maxLines: widget.maxLines ?? 1,
      validator: widget.validator ?? (val) {},
      focusNode: widget.focusNode ?? FocusNode(),
      onChanged: (val) {
        setState(() {});
      },
      decoration: InputDecoration(
          hintText: widget.hintText ?? "",
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.grey)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.grey)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Color(0xffb30000))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.grey))),
    );
  }
}
