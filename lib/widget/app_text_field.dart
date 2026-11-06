import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class AppTextField extends StatefulWidget {
  // ——— Label above field ———
  final bool showLabel;
  final String labelText;
  final String hintText;
  final TextStyle? labelStyle;
  final InlineSpan? richLabel;

  // ——— Core ———
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  // ——— Behavior ———
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool readOnly;
  final bool obscureText;
  final bool showPasswordToggle;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool enableInteractiveSelection;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  // ——— Callbacks ———
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;

  // ——— Styling ———
  final TextStyle? style;
  final bool? filled;

  const AppTextField({
    super.key,
    this.showLabel = true,
    this.labelText = '',
    this.hintText = '',
    this.labelStyle,
    this.richLabel,
    required this.controller,
    this.focusNode,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.autovalidateMode,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.enableInteractiveSelection = true,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.style,
    this.suffixIcon,
    this.prefixIcon,
    this.filled,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel && widget.labelText.isNotEmpty) ...[
          widget.richLabel != null
              ? RichText(text: widget.richLabel!)
              : Texts(widget.labelText, fontSize: 15, letterSpacing: 1),
          const SizedBox(height: 12),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          readOnly: widget.readOnly,
          obscureText: widget.obscureText ? _obscure : false,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          style:
              widget.style ??
              Styles.textStyle(color: AppColor.black, fontSize: 16),
          decoration: InputDecoration(
            counterText: "",
            hintText: widget.hintText,
            hintStyle: Styles.textStyle(
              color: AppColor.subtitleColor,
              fontSize: 15,
            ),
            filled: widget.filled,
            fillColor: widget.filled == true
                ? const Color(0xFFF2F5F8)
                : AppColor.transparent,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: widget.filled == true
                  ? BorderSide.none
                  : BorderSide(color: AppColor.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: widget.filled == true
                  ? BorderSide.none
                  : BorderSide(color: AppColor.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: widget.filled == true
                  ? BorderSide.none
                  : const BorderSide(color: AppColor.primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColor.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColor.error, width: 2),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.showPasswordToggle
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  )
                : widget.suffixIcon,
          ),
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          autofocus: widget.autofocus,
          textCapitalization: widget.textCapitalization,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          inputFormatters: widget.inputFormatters,
          expands: widget.expands,
          enableInteractiveSelection: widget.enableInteractiveSelection,
        ),
      ],
    );
  }
}
