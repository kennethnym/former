import 'package:flutter/material.dart';
import 'package:former/former.dart';
import 'package:provider/provider.dart';

/// A widget that shows an error message of a given field.
/// If there is no error message an empty [Container] is built.
class FormerError extends StatelessWidget {
  final Widget? child;
  final FormerField field;

  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// Creates an error message for [field].
  ///
  /// If [child] is not given, [Text] will be used to display the message.
  /// To consume the error message, use [Former.of] to obtain [FormerProvider],
  /// then call [FormerProvider.errorOf].
  ///
  /// This constructor mirrors all the options for the [Text] widget.
  const FormerError({
    Key? key,
    required this.field,
    this.child,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = this.child;
    if (child != null) return child;

    return Selector<FormerProvider, String>(
      selector: (_, provider) => provider.errorOf(field),
      builder: (_, error, __) => Text(
        error,
        style: style ??
            TextStyle(
              color: Theme.of(context).errorColor,
            ),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      ),
    );
  }
}
