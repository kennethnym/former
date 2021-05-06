import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:former/former.dart';
import 'package:provider/provider.dart';

/// A normal [Slider] that:
///   - controls the given field
///   - follows whether the form is enabled (can override in constructor)
class FormerSlider extends StatefulWidget {
  final FormerField field;
  final bool? enabled;

  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;
  final MouseCursor? mouseCursor;
  final SemanticFormatterCallback? semanticFormatterCallback;
  final FocusNode? focusNode;
  final bool autofocus;

  /// Creates a [Slider] that consumes the [FormerForm] in context.
  ///
  /// By default, the enabled state of this field follows that of [FormerForm].
  /// This can be overridden with the [enabled] option.
  const FormerSlider({
    Key? key,
    required this.field,
    this.enabled,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.mouseCursor,
    this.semanticFormatterCallback,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  _FormerSliderState createState() => _FormerSliderState();
}

class _FormerSliderState extends State<FormerSlider> with FormerProviderMixin {
  late num _value;

  /// Whether the field is an integer field.
  /// If true, then the [double] obtained from [Slider] has to be converted
  /// to an integer before it can be stored to the field.
  ///
  /// No conversion is required to assign the [double] value obtained to
  /// a [num] field since [num] is a super type of [double].
  late final bool _isInt;

  void _updateValue(double newValue) {
    formProvider.update(
      field: widget.field,
      withValue: _isInt ? newValue.toInt() : newValue,
    );
    setState(() {
      _value = newValue;
    });
  }

  /// Verifies whether [value] is of type that this control can handle.
  bool _isCorrectType(dynamic value) {
    final isDouble = value is double || value is double?;
    final isNum = value is num || value is num?;

    return _isInt || isDouble || isNum;
  }

  @override
  void initState() {
    super.initState();

    final initialValue = formProvider.form[widget.field];

    _isInt = initialValue is int || initialValue is int?;

    assert(
      _isCorrectType(initialValue),
      '${widget.field} is not a number, but FormerSlider is used to control the field. '
      'FormerSlider can only control number fields.',
    );

    _value = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FormerProvider, bool>(
      selector: (_, provider) => provider.isFormEnabled,
      builder: (_, isFormEnabled, __) => Slider(
        value: _value.toDouble(),
        onChanged: (widget.enabled ?? isFormEnabled) ? _updateValue : null,
        onChangeStart: widget.onChangeStart,
        onChangeEnd: widget.onChangeEnd,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        label: widget.label,
        activeColor: widget.activeColor,
        inactiveColor: widget.inactiveColor,
        mouseCursor: widget.mouseCursor,
        semanticFormatterCallback: widget.semanticFormatterCallback,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
      ),
    );
  }
}
