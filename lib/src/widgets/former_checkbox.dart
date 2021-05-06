import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:former/former.dart';
import 'package:provider/provider.dart';

class FormerCheckbox extends StatefulWidget {
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
  _FormerCheckboxState createState() => _FormerCheckboxState();
}

class _FormerCheckboxState extends State<FormerCheckbox>
    with FormerProviderMixin {
  late bool _isChecked;

  void _toggle(bool? checked) {}

  @override
  void initState() {
    super.initState();

    final initialValue = formProvider.form[widget.field];

    assert(
      (!widget.tristate && initialValue is bool) ||
          (widget.tristate && initialValue is bool?),
      'FormerCheckbox is not compatible with the type of field ${widget.field}.\n'
      'If ${widget.field} is a nullable bool, then FormerCheckbox.tristate must be enabled.\n'
      'If ${widget.field} is a bool, then FormerCheckbox.tristate must be disabled.\n'
      'Otherwise, you should use a Former control that is compatible with the type of ${widget.field}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FormerProvider, bool>(
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
