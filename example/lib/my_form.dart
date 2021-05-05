import 'package:former_gen/former_gen.dart';
import 'package:former/former.dart';
import 'package:former/validators.dart';

part 'my_form.g.dart';

class MyForm = _MyForm with _$MyFormIndexable;

@Formable()
abstract class _MyForm implements FormerForm {
  String username = '';
  String email = '';

  @FormableIgnore()
  String ignored = '';

  @override
  Future<void> submit() {
    // TODO: implement submit
    return Future.value();
  }
}
