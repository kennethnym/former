import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:former/former.dart';

import '../test_form.dart';

/// Wraps [control] with [Former] that provides [TestForm] and [testSchema].
Widget wrapWithFormer({required Widget control}) => MaterialApp(
      home: Scaffold(
        body: Former(
          form: () => TestForm(),
          schema: () => testSchema,
          child: control,
        ),
      ),
    );
