import 'package:dummy_trade/model/auth_services.dart';
import 'package:dummy_trade/screens/auth_screen/otp_screen.dart';
import 'package:dummy_trade/widgets/custom_edittext_box.dart';
import 'package:dummy_trade/widgets/sign_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../constants/style.dart';
import '../../main.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/passwordEditText.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "Sign-up-Screen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _userNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmcontroller = TextEditingController();
  bool showText = true;
  bool conpass = false;

  bool confirmPassword() {
    setState(() {
      if (passwordcontroller.text == confirmcontroller.text) {
        conpass = true;
      }
    });
    return conpass;
  }

  void showPassword() {
    setState(() {
      showText = !showText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Form(
            key: formKey,
            child: AutofillGroup(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: kEmailEditTextDecoration.copyWith(
                          hintText: "userName", labelText: "UserName"),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      controller: _userNamecontroller,
                      autofillHints: const [AutofillHints.name],
                      //use to validate email
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    EmailEditText(
                      hint: "type your email",
                      inputType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      autofillHints: const [AutofillHints.email],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IntlPhoneField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      onChanged: (phone) {
                        // setState((){_phonecontroller.text=phone.completeNumber;});
                        _phonecontroller.text = phone.completeNumber;
                        print(
                            "${phone.completeNumber}\n${_phonecontroller.text}");
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PasswordEditText(
                      showText: showText,
                      hint: "type your password",
                      inputType: TextInputType.number,
                      controller: passwordcontroller,
                      autofillHint: const [AutofillHints.password],
                      onPressed: showPassword,
                    ),
                    const SizedBox(height: 20),
                    PasswordEditText(
                      showText: showText,
                      hint: "confirm  your password",
                      inputType: TextInputType.number,
                      controller: confirmcontroller,
                      autofillHint: const [AutofillHints.password],
                      onPressed: showPassword,
                    ),
                    const SizedBox(height: 20),
                    // confirmPassword() ?
                    Visibility(
                      visible: confirmPassword(),
                      child: SignButton(
                          buttoncolor: Colors.blue,
                          textcolor: Colors.white,
                          buttonText: "sign up",
                          onPressed: () {
                            AuthService().signup(
                                 context,
                                emailcontroller.text.trim(),
                                passwordcontroller.text.trim(),
                                _userNamecontroller.text.trim(),
                                formKey);
                            Provider.of<AuthProvider>(context, listen: false)
                                .createUserWithPhone(_phonecontroller.text);
                            navigatorKey.currentState!
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                          phoneNumber:
                                              _phonecontroller.text.trim(),
                                        )));
                          },
                          iconData: Icons.lock_open),
                    )
                    // : const Text(
                    //     "password is not same",
                    //     style: TextStyle(color: Colors.red, fontSize: 20),
                    //   )
                  ]),
            ),
          )),
    );
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    _phonecontroller.dispose();
    _userNamecontroller.dispose();
    super.dispose();
  }
}
