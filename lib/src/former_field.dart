import 'package:flutter/cupertino.dart';

import 'former_form.dart';

/// Describes a field in [FormerForm].
abstract class FormerField {
  @protected
  const FormerField(this.value);

  final int value;
}
