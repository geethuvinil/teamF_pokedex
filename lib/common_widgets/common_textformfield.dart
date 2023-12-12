import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonTextFormFieldWidget extends StatefulWidget {
  final String? hintString;
    final String? labelString;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
    final int? maxLines;
  final bool? obscureText;
  final bool? enabled;
  final TextCapitalization? textCapitalization;
  final Function(String)? onChanged;
  final TextAlign? textAlign;
  

  CommonTextFormFieldWidget(
      {super.key,
      this.hintString,
      this.labelString,
      this.controller,
      this.inputType,
      this.prefixIconWidget,
      this.suffixIconWidget,
      this.enabled,
      this.maxLines,this.obscureText,
      this.onChanged,this.textAlign,
      this.textCapitalization,});

  @override
  State<CommonTextFormFieldWidget> createState() =>
      _CommonTextFormFieldWidgetState();
}

class _CommonTextFormFieldWidgetState extends State<CommonTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      maxLines: widget.maxLines,
      keyboardType: widget.inputType,
       textCapitalization: widget.textCapitalization??TextCapitalization.none,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.black
        ),
        labelText: widget.labelString,
        hintText: widget.hintString?? '',
        suffixIcon: widget.suffixIconWidget,
        prefixIcon: widget.prefixIconWidget,
        focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder()
        
      ),
    );
  }
}
