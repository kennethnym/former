import 'package:former_gen/former_gen.dart';
import 'package:former/former.dart';
import 'package:former/validators.dart';

part 'my_form.g.dart';

@Formable()
abstract class MyFormBase {
  String username = '';
  String email = '';

  @FormableIgnore()
  String ignored = '';
}
