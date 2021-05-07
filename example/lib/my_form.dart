import 'package:former_gen/former_gen.dart';
import 'package:former/former.dart';
import 'package:former/validators.dart';

part 'my_form.g.dart';

class MyForm = _MyForm with _$MyFormIndexable;

@Formable()
abstract class _MyForm implements FormerForm {
  String username = '';
  String email = '';
  int age = 1;
  bool shouldSendNewsletter = false;
  bool shouldEnableAnalytics = false;

  @FormableIgnore()
  String ignored = '';

  @override
  Future<void> submit() {
    print(toJson());
    return Future.value();
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'age': age,
        'shouldSendNewsletter': shouldSendNewsletter,
        'shouldEnableAnalytics': shouldEnableAnalytics,
      };
}
