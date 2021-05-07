import 'package:former/former.dart';

class TestForm implements FormerForm {
  @override
  operator [](FormerField field) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  void operator []=(FormerField field, newValue) {
    // TODO: implement []=
  }

  @override
  Future<void> submit() {
    return Future.value();
  }
}

class TestFormSchema extends FormerSchema {
  @override
  String errorOf(FormerField field) {
    // TODO: implement errorOf
    throw UnimplementedError();
  }

  @override
  bool validate(FormerForm form) {
    // TODO: implement validate
    throw UnimplementedError();
  }
}
