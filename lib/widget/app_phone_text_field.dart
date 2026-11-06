// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class AppPhoneTextField extends StatefulWidget {
//   // ——— Label above field ———
//   final bool showLabel;
//   final String labelText;
//   final String hintText;
//   final TextStyle? labelStyle;
//   final InlineSpan? richLabel;

//   // ——— Core ———
//   final TextEditingController controller;
//   final FocusNode? focusNode;
//   final String? Function(String?)? validator;

//   // ——— Behavior ———
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final List<TextInputFormatter>? inputFormatters;
//   final bool autofocus;
//   final bool readOnly;
//   final bool obscureText;
//   final bool showPasswordToggle;
//   final AutovalidateMode? autovalidateMode;
//   final TextCapitalization textCapitalization;
//   final TextAlign textAlign;
//   final TextDirection? textDirection;
//   final int? maxLength;
//   final int? maxLines;
//   final int? minLines;
//   final bool expands;
//   final bool enableInteractiveSelection;

//   // ——— Callbacks ———
//   final ValueChanged<String>? onChanged;
//   final VoidCallback? onTap;
//   final VoidCallback? onEditingComplete;
//   final ValueChanged<String>? onFieldSubmitted;

//   // ——— Styling ———
//   final TextStyle? style;

//   final ValueChanged<CountryCode>? onCountryChanged;

//   const AppPhoneTextField({
//     super.key,
//     this.showLabel = true,
//     this.labelText = '',
//     this.hintText = '',
//     this.labelStyle,
//     this.richLabel,
//     required this.controller,
//     this.focusNode,
//     this.validator,
//     this.keyboardType,
//     this.textInputAction,
//     this.inputFormatters,
//     this.autofocus = false,
//     this.readOnly = false,
//     this.obscureText = false,
//     this.showPasswordToggle = false,
//     this.autovalidateMode,
//     this.textCapitalization = TextCapitalization.none,
//     this.textAlign = TextAlign.start,
//     this.textDirection,
//     this.maxLength,
//     this.maxLines = 1,
//     this.minLines,
//     this.expands = false,
//     this.enableInteractiveSelection = true,
//     this.onChanged,
//     this.onTap,
//     this.onEditingComplete,
//     this.onFieldSubmitted,
//     this.style,
//     this.onCountryChanged,
//   });

//   @override
//   State<AppPhoneTextField> createState() => _AppPhoneTextFieldState();
// }

// class _AppPhoneTextFieldState extends State<AppPhoneTextField> {
//   bool _obscure = false;

//   @override
//   void initState() {
//     super.initState();
//     _obscure = widget.obscureText;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     final borderColor = isDarkMode ? Colors.white54 : AppColor.colorBlack;

//     final textColor = isDarkMode ? AppColor.colorWhite : AppColor.colorBlack;

//     final hintColor = isDarkMode ? Colors.white70 : AppColor.colorBlack;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.showLabel && widget.labelText.isNotEmpty) ...[
//           widget.richLabel != null
//               ? RichText(text: widget.richLabel!)
//               : Texts(widget.labelText, fontSize: 15, letterSpacing: 1),
//           const SizedBox(height: 12),
//         ],
//         TextFormField(
//           controller: widget.controller,
//           focusNode: widget.focusNode,
//           validator: widget.validator,
//           keyboardType: widget.keyboardType,
//           textInputAction: widget.textInputAction,
//           inputFormatters: widget.inputFormatters,
//           autofocus: widget.autofocus,
//           readOnly: widget.readOnly,
//           obscureText: widget.obscureText ? _obscure : false,
//           autovalidateMode: widget.autovalidateMode,
//           textCapitalization: widget.textCapitalization,
//           textAlign: widget.textAlign,
//           textDirection: widget.textDirection,
//           maxLength: widget.maxLength ?? 10,
//           maxLines: widget.maxLines,
//           minLines: widget.minLines,
//           expands: widget.expands,
//           enableInteractiveSelection: widget.enableInteractiveSelection,
//           onChanged: widget.onChanged,
//           onTap: widget.onTap,
//           onEditingComplete: widget.onEditingComplete,
//           onFieldSubmitted: widget.onFieldSubmitted,
//           cursorColor: AppColor.colorBlack,
//           style: widget.style ?? Styles.textStyle(color: textColor),
//           decoration: InputDecoration(
//             counterText: '',
//             // only hint inside box, label is outside
//             hintText: widget.hintText,
//             hintStyle: Styles.textStyle(color: hintColor, fontSize: 16),
//             // box look
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 16,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14),
//               borderSide: BorderSide(color: borderColor),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14),
//               borderSide: BorderSide(color: borderColor),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14),
//               borderSide: BorderSide(color: borderColor),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14),
//               borderSide: BorderSide(color: borderColor),
//             ),

//             prefixIcon: CountryCodePicker(
//               onChanged: (code) {
//                 setState(() {});
//                 widget.onCountryChanged?.call(code);
//               },
//               initialSelection: 'IN',
//               favorite: const ['+91', 'IN'],
//               showCountryOnly: false,
//               showOnlyCountryWhenClosed: false,
//               alignLeft: false,
//               textStyle: Styles.textStyle(
//                 color: Theme.of(context).brightness == Brightness.dark
//                     ? AppColor.darkText
//                     : AppColor.lightText,
//               ),
//             ),

//             prefixIconConstraints: const BoxConstraints(minWidth: 0),

//             // password eye icon
//             suffixIcon: widget.showPasswordToggle
//                 ? IconButton(
//                     icon: Icon(
//                       _obscure ? Icons.visibility_off : Icons.visibility,
//                       color: textColor,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscure = !_obscure;
//                       });
//                     },
//                   )
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }
