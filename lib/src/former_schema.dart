import 'package:flutter/cupertino.dart';
import 'package:former/former.dart';

/// A schema for [FormerForm] that checks whether a [FormerForm]
/// conforms to the schema.
abstract class FormerSchema<TForm extends FormerForm> {
  const FormerSchema();

  /// Validates the [form] by checking whether it conforms to this schema.
  /// Returns true if [form] is valid, false otherwise.
  bool validate(TForm form);

  /// Retrieves the error message of [field]. Empty if [field] is valid.
  String errorOf(FormerField field);

  @protected
  bool fieldIsValid(bool isValidated) => isValidated;
}
