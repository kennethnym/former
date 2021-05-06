import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:former/former.dart';
import 'package:provider/provider.dart';

class FormerSwitch extends StatefulWidget {
  final FormerField field;
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
  _FormerSwitchState createState() => _FormerSwitchState();
}

class _FormerSwitchState extends State<FormerSwitch> with FormerProviderMixin {
  late bool _isSwitchedOn;

  void _toggleSwitch(bool isOn) {
    setState(() {
      _isSwitchedOn = isOn;
    });
  }

  @override
  void initState() {
    super.initState();

    final initialValue = formProvider.form[widget.field];

    assert(
      initialValue is bool,
      'FormerSwitch is incompatible with the type of ${widget.field}.\n'
      'FormerSwitch can only control fields of type bool. '
      'You should use a Former control that is compatible with the type of ${widget.field}.',
    );

    _isSwitchedOn = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FormerProvider, bool>(
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
