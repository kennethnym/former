import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:former/src/form_provider.dart';
import 'package:former/src/former_field.dart';
import 'package:provider/provider.dart';

class FormerTextField extends StatefulWidget {
  final FormerField field;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final String? restorationId;

  const FormerTextField({
    required this.field,
    Key? key,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.restorationId,
  }) : super(key: key);

  @override
  _FormerTextFieldState createState() => _FormerTextFieldState();
}

class _FormerTextFieldState extends State<FormerTextField>
    with FormProviderMixin {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    final initialValue = formProvider.form[widget.field];

    _controller = widget.controller ?? TextEditingController();
    _controller
      ..text = initialValue
      ..addListener(() {
        formProvider.update(
          field: widget.field,
          withValue: _controller.text,
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FormerProvider, bool>(
      selector: (_, provider) => provider.isFormEnabled,
      builder: (_, isFormEnabled, __) => TextField(
        key: widget.key,
        controller: _controller,
        focusNode: widget.focusNode,
        decoration: widget.decoration,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        style: widget.style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        readOnly: widget.readOnly,
        toolbarOptions: widget.toolbarOptions,
        showCursor: widget.showCursor,
        autofocus: widget.autofocus,
        obscuringCharacter: widget.obscuringCharacter,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        smartDashesType: widget.smartDashesType,
        enableSuggestions: widget.enableSuggestions,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled ?? isFormEnabled,
        cursorWidth: widget.cursorWidth,
        cursorRadius: widget.cursorRadius,
        cursorColor: widget.cursorColor,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        dragStartBehavior: widget.dragStartBehavior,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        selectionControls: widget.selectionControls,
        onTap: widget.onTap,
        mouseCursor: widget.mouseCursor,
        buildCounter: widget.buildCounter,
        scrollController: widget.scrollController,
        scrollPhysics: widget.scrollPhysics,
        autofillHints: widget.autofillHints,
        restorationId: widget.restorationId,
      ),
    );
  }
}
