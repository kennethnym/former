import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:former/former.dart';
import 'package:provider/provider.dart';

/// A normal [Slider] that:
///   - controls the given field
///   - follows whether the form is enabled (can override in constructor)
///
/// [Slider] returns a [double] when changed. When an [int] field is passed
/// to [FormerSlider], the [double] is truncated to an [int] with [num.toInt].
/// No special casting is done when it is a [num] field.
///
/// [TForm] must be specified in order for [FormerSlider] to find the correct
/// form in context.
class FormerSlider<TForm extends FormerForm> extends StatefulWidget {
  /// The [FormerField] this slider controls.
  final FormerField field;

  /// Whether this slider is enabled. Follows whether the form is enabled
  /// when not overridden.
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
  /// [field] has to be a [num] field, an [int] field, or a [double] field.
  /// The field can be nullable.
  ///
  /// An [AssertionError] is thrown when [field] is incompatible.
  ///
  /// By default, the enabled state of this field follows that of [FormerForm].
  /// This can be overridden with the [enabled] option.
  ///
  /// This constructor mirrors all the options of the [Slider] widget.
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
  _FormerSliderState<TForm> createState() => _FormerSliderState();
}

class _FormerSliderState<F extends FormerForm> extends State<FormerSlider> {
  late final FormerProvider<F> _formProvider;
  late num _value;

  /// Whether the field is an integer field.
  /// If true, then the [double] obtained from [Slider] has to be converted
  /// to an integer before it can be stored to the field.
  ///
  /// No conversion is required to assign the [double] value obtained to
  /// a [num] field since [num] is a super type of [double].
  late final bool _isInt;

  void _updateValue(double newValue) {
    _formProvider.update(
      field: widget.field,
      withValue: _isInt ? newValue.toInt() : newValue,
    );
    setState(() {
      _value = newValue;
    });
  }

  /// Verifies whether [value] is of type that this control can handle.
  bool get _isCorrectType {
    final type = _formProvider.form.typeOf(widget.field);
    final isDouble = type == 'double' || type == 'double?';
    final isNum = type == 'num' || type == 'num?';

    return _isInt || isDouble || isNum;
  }

  @override
  void initState() {
    super.initState();

    _formProvider = Former.of(context, listen: false);
    final initialValue = _formProvider.form[widget.field];
    final fieldType = _formProvider.form.typeOf(widget.field);

    _isInt = fieldType == 'int' || fieldType == 'int?';

    assert(
      _isCorrectType,
      '${widget.field} is not a number, but FormerSlider is used to control the field. '
      'Type received: $fieldType.\n'
      'FormerSlider can only control number fields.',
    );

    _value = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FormerProvider<F>, bool>(
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
