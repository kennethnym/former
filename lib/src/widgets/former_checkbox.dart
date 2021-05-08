import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:former/former.dart';
import 'package:provider/provider.dart';

class FormerCheckbox<TForm extends FormerForm> extends StatefulWidget {
  final FormerField field;
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
