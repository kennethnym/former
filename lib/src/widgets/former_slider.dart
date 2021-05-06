import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:former/former.dart';

class FormerSlider extends StatefulWidget {
  final FormerField field;

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

  const FormerSlider({
    Key? key,
    required this.field,
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
  late final num _initialValue;

  @override
  void initState() {
    super.initState();

    _initialValue = formProvider.form[widget.field];
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _initialValue.toDouble(),
      onChanged: onChanged,
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
    );
  }
}
