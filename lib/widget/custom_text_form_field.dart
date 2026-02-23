import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final Icon? icon;
  final String? errorMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  bool? obscureText;

  final IconButton? iconButton;
  CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.obscureText,
    this.icon,
    this.iconButton,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool mustraContrasenia = true;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(20));
    widget.obscureText ??= false;
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: widget.obscureText! ? mustraContrasenia : false,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red.shade800),
        ),
        label: widget.label != null ? Text(widget.label!) : null,
        hintText: widget.hint,
        focusColor: colors.primary,
        prefixIcon: (widget.obscureText!
            ? IconButton(
                onPressed: () {
                  setState(() {
                    mustraContrasenia = !mustraContrasenia;
                  });
                },
                icon: Icon(Icons.remove_red_eye),
              )
            : widget.icon),
        prefixIconColor: colors.primary,
        errorText: widget.errorMessage,
      ),
    );
  }
}
