import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../former_form.dart';
import '../former_field.dart';
import '../former_provider.dart';
import 'former.dart';

/// A normal [Switch] that:
///   - controls the given field
///   - follows whether the form is enabled (can override in constructor)
///
/// The given field has to be a non-nullable [bool] field.
///
/// If the field is incompatible, an [AssertionError] is thrown.
class FormerSwitch<TForm extends FormerForm> extends StatefulWidget {
  /// The [FormerField] this switch controls.
  final FormerField field;

  /// Whether [FormerSwitch] is enabled. Follows whether the form is enabled
  /// when not overridden.
  final bool? enabled;

  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final ImageProvider<Object>? activeThumbImage;
  final ImageErrorListener? onActiveThumbImageError;
  final ImageProvider<Object>? inactiveThumbImage;
  final ImageErrorListener? onInactiveThumbImageError;
  final MaterialStateProperty<Color?>? thumbColor;
  final MaterialStateProperty<Color?>? trackColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final bool autofocus;

  /// Creates a [Switch] that consumes the [FormerForm] in context.
  ///
  /// [field] has to be a non-nullable [bool] field.
  ///
  /// An [AssertionError] is thrown when [field] is incompatible.
  ///
  /// By default, the enabled state of this field follows that of [FormerForm].
  /// This can be overridden with the [enabled] option.
  ///
  /// This constructor mirrors all the options of the [Switch] widget.
  const FormerSwitch({
    Key? key,
    required this.field,
    this.enabled,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.thumbColor,
    this.trackColor,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  _FormerSwitchState<TForm> createState() => _FormerSwitchState();
}

class _FormerSwitchState<F extends FormerForm> extends State<FormerSwitch> {
  late final FormerProvider<F> _formProvider;
  late bool _isSwitchedOn;

  void _toggleSwitch(bool isOn) {
    setState(() {
      _isSwitchedOn = isOn;
    });
    _formProvider.update(field: widget.field, withValue: isOn);
  }

  @override
  void initState() {
    super.initState();

    _formProvider = Former.of(context, listen: false);
    final initialValue = _formProvider.form[widget.field];
    final fieldType = _formProvider.form.typeOf(widget.field);

    assert(
      _formProvider.form.typeOf(widget.field) == 'bool',
      'FormerSwitch is incompatible with the type of ${widget.field}}. '
      'Type received: $fieldType\n'
      'FormerSwitch can only control fields of type bool. '
      'You should use a Former control that is compatible with the type of ${widget.field}.',
    );

    _isSwitchedOn = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FormerProvider<F>, bool>(
      selector: (_, provider) => provider.isFormEnabled,
      builder: (_, isFormEnabled, __) => Switch(
        value: _isSwitchedOn,
        onChanged: (widget.enabled ?? isFormEnabled) ? _toggleSwitch : null,
        activeColor: widget.activeColor,
        activeTrackColor: widget.activeTrackColor,
        inactiveThumbColor: widget.inactiveThumbColor,
        inactiveTrackColor: widget.inactiveTrackColor,
        activeThumbImage: widget.activeThumbImage,
        onActiveThumbImageError: widget.onActiveThumbImageError,
        inactiveThumbImage: widget.inactiveThumbImage,
        onInactiveThumbImageError: widget.onInactiveThumbImageError,
        thumbColor: widget.thumbColor,
        trackColor: widget.trackColor,
        materialTapTargetSize: widget.materialTapTargetSize,
        dragStartBehavior: widget.dragStartBehavior,
        mouseCursor: widget.mouseCursor,
        focusColor: widget.focusColor,
        hoverColor: widget.hoverColor,
        overlayColor: widget.overlayColor,
        splashRadius: widget.splashRadius,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
      ),
    );
  }
}
