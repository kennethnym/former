import 'package:former/src/former_field.dart';

/// A form that will be consumed by [Former].
/// This ensures the form class interfaces with this library properly.
abstract class FormerForm {
  Future<void> submit();

  operator [](FormerField field);

  operator []=(FormerField field, dynamic newValue);
}
