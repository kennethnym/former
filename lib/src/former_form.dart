import 'package:flutter/widgets.dart';

import 'former_field.dart';

/// A form that will be consumed by [Former].
/// This ensures the form class interfaces with this library properly.
abstract class FormerForm {
  /// A map that maps [FormerField] to their corresponding type.
  @protected
  abstract final Map<FormerField, String> fieldType;

  /// Submits this form, under the [context] of the [Former] widget that
  /// provides this form.
  ///
  /// If you need to access any value in [context], make sure they are parents
  /// of the [Former] widget that provides the form.
  Future submit(BuildContext context);

  /// Retrieves the type of [field].
  /// If [field] is not in this form, an empty string is returned.
  String typeOf(FormerField field) => fieldType[field] ?? '';

  operator [](FormerField field);

  operator []=(FormerField field, dynamic newValue);
}
