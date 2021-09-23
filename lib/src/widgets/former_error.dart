import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/assert_has_generic.dart';
import '../former_form.dart';
import '../former_field.dart';
import '../former_provider.dart';
import 'former.dart';

/// A widget that shows an error message of the given field. If the field
/// doesn't have any error, an empty [Container] is built.
///
/// The error message has a default red color taken from the [Theme] in context.
class FormerError<TForm extends FormerForm> extends StatelessWidget {
  /// The child of the [Widget] returned by [builder] that does not depend
  /// on the error value.
  final Widget? child;

  /// [FormerError] will show the error message of this field.
  final FormerField field;

  /// A builder function that takes in the error of [field] and the current [BuildContext]
  /// and builds a widget that consumes the error.
  ///
  /// Use [String.isEmpty] to check whether [field] has an error.
  /// If [field] is valid and does not contain any error,
  /// calling [String.isEmpty] on [error] will return true.
  ///
  /// The [Widget] that is passed to [FormerError.child] is available
  /// through the `child` parameter (the 3rd parameter).
  final Widget Function(BuildContext, String error, Widget? child)? builder;

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
  /// To override the default style of the error message, pass a [TextStyle]
  /// to [style].
  ///
  /// This constructor mirrors all the options of the [Text] widget.
  const FormerError({
    Key? key,
    required this.field,
    this.builder,
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
    assertHasGeneric<TForm>(forWidget: 'FormerError');

    return Selector<FormerProvider<TForm>, String>(
      selector: (_, provider) => provider.errorOf(field),
      builder: (_, error, child) {
        final builder = this.builder;
        print('builder $builder');
        if (builder != null) {
          return builder(context, error, child);
        }
        if (error.isEmpty) return Container();
        return Text(
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
        );
      },
      child: child,
    );
  }
}
