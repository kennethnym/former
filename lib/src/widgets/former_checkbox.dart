import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../former_form.dart';
import '../former_field.dart';
import '../former_provider.dart';
import 'former.dart';

/// A normal [Checkbox] that
///   - updates the value of the given field in the form whenever it changes.
///   - follows whether the form is enabled (can override in constructor)
///
/// The given field has to be:
///   - a boolean field ([tristate] must be **off**), or
///   - a nullable boolean field ([tristate] must be **on**).
///
/// If the field is incompatible, an [AssertionError] will be thrown.
class FormerCheckbox<TForm extends FormerForm> extends StatefulWidget {
  /// The [FormerField] this checkbox controls.
  final FormerField field;

  /// Whether [FormerCheckbox] is enabled. Follows whether the form is enabled
  /// when not overridden.
  final bool? enabled;

  final bool? value;
  final bool tristate;
  final ValueChanged<bool?>? onChanged;
  final MouseCursor? mouseCursor;
  final Color? activeColor;
  final MaterialStateProperty<Color?>? fillColor;
  final Color? checkColor;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final FocusNode? focusNode;
  final bool autofocus;

  /// Creates a checkbox that consumes the [FormerForm] in context.
  ///
  /// [field] has to be:
  ///   - a boolean field ([tristate] must be **off**), or
  ///   - a nullable boolean field ([tristate] must be **on).
  ///
  /// An [AssertionError] is thrown if [field] is incompatible.
  ///
  /// By default, the enabled state of this field follows that of [FormerForm].
  /// This can be overridden with the [enabled] option.
  ///
  /// This constructor mirrors all the options for the [Checkbox] widget.
  const FormerCheckbox({
    Key? key,
    required this.field,
    this.enabled,
    this.value,
    this.onChanged,
    this.tristate = false,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  _FormerCheckboxState<TForm> createState() => _FormerCheckboxState();
}

class _FormerCheckboxState<F extends FormerForm> extends State<FormerCheckbox> {
  late final FormerProvider<F> _formProvider;
  late bool? _isChecked;

  void _toggle(bool? checked) {
    setState(() {
      _isChecked = checked;
    });
    _formProvider.update(field: widget.field, withValue: checked);
  }

  @override
  void initState() {
    super.initState();

    _formProvider = Former.of(context, listen: false);
    final initialValue = _formProvider.form[widget.field];
    final fieldType = _formProvider.form.typeOf(widget.field);

    assert(
      (!widget.tristate && fieldType == 'bool') ||
          (widget.tristate && fieldType == 'bool?'),
      'FormerCheckbox is not compatible with the type of field ${widget.field}. '
      'Type received: $fieldType. \n'
      'If ${widget.field} is a nullable bool, then FormerCheckbox.tristate must be enabled.\n'
      'If ${widget.field} is a bool, then FormerCheckbox.tristate must be disabled.\n'
      'Otherwise, you should use a Former control that is compatible with the type of ${widget.field}.',
    );

    _isChecked = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FormerProvider<F>, bool>(
      selector: (_, provider) => provider.isFormEnabled,
      builder: (_, isFormEnabled, __) => Checkbox(
        value: _isChecked,
        onChanged: (widget.enabled ?? isFormEnabled) ? _toggle : null,
        tristate: widget.tristate,
        mouseCursor: widget.mouseCursor,
        activeColor: widget.activeColor,
        fillColor: widget.fillColor,
        checkColor: widget.checkColor,
        focusColor: widget.focusColor,
        hoverColor: widget.hoverColor,
        overlayColor: widget.overlayColor,
        splashRadius: widget.splashRadius,
        materialTapTargetSize: widget.materialTapTargetSize,
        visualDensity: widget.visualDensity,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
      ),
    );
  }
}
