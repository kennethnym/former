import 'package:former_gen/former_gen.dart';
import 'package:former/former.dart';

// part 'my_form.g.dart';

@Formable()
class MyFormBase {
  String username = '';
  String email = '';

  @FormableIgnore()
  String ignored = '';
}
