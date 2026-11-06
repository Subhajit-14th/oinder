import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';

class Texts extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign textAlign;
  final double? letterSpacing;
  final TextDecoration? textDecoration;
  final shadows;
  final bool? softWrap;
  final FontStyle? fontStyle;
  final TextDirection? textDirection;
  final double height;
  final Paint? foreGround;

  /// if set and not null then all of the default values will be ignored
  /// for this text widget that is color,fontSize etc...
  final TextStyle? textStyle;

  const Texts(
    this.text, {
    super.key,
    this.fontSize = 14.0,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.maxLines,
    this.overflow,
    this.textAlign = TextAlign.start,
    this.letterSpacing,
    this.textDecoration,
    this.shadows,
    this.softWrap,
    this.fontStyle,
    this.textStyle,
    this.textDirection,
    this.height = 1.0,
    this.foreGround,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Text(
      text,
      key: Key(text),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      style:
          textStyle ??
          Styles.textStyle(
            height: height,
            fontSize: fontSize,
            color: color ?? textColor!,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing ?? 1,
            textDecoration: textDecoration,
            shadows: shadows,
            fontStyle: fontStyle,
            foreGround: foreGround,
          ),
      strutStyle: StrutStyle(
        height: height,
        fontSize: fontSize,
        forceStrutHeight: true,
      ),
    );
  }
}
