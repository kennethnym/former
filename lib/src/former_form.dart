import 'package:flutter/cupertino.dart';
import 'package:former/src/former_field.dart';

/// A form that will be consumed by [Former].
/// This ensures the form class interfaces with this library properly.
abstract class FormerForm {
  /// A map that maps [FormerField] to their corresponding type.
  @protected
  abstract final Map<FormerField, String> fieldType;

  Future<void> submit();

  /// Retrieves the type of [field].
  /// If [field] is not in this form, an empty string is returned.
  String typeOf(FormerField field) => fieldType[field] ?? '';

  operator [](FormerField field);

  operator []=(FormerField field, dynamic newValue);
}
