import 'package:email_validator/email_validator.dart';

class Validator{

  emailValidator(email)=> email != null && !EmailValidator.validate(email)
      ? "Enter a valid email"
      : null;
}