import 'package:dummy_trade/main.dart';
import 'package:dummy_trade/model/local_auth_api.dart';
import 'package:dummy_trade/screens/auth_screen/forget_password_screen.dart';
import 'package:dummy_trade/screens/home_screen.dart';
import 'package:dummy_trade/widgets/language_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../model/auth_services.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/custom_edittext_box.dart';
import '../../widgets/passwordEditText.dart';
import '../../widgets/sign_button.dart';

class SignInScreen extends StatefulWidget {
  static const routesName = "Sign-in-Screen";

  final GestureTapCallback? onClickedSignUp;

  const SignInScreen({Key? key, this.onClickedSignUp}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool showText = true;

  void showPassword() {
    setState(() {
      showText = !showText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("sign in"),
          centerTitle: true,
          actions: [LangugaePicker(),SizedBox(width: 12,)],
        ),
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
                    EmailEditText(
                      hint: AppLocalizations.of(context)!.email,
                      inputType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      autofillHints: const [AutofillHints.email],
                    ),
                    const SizedBox(height: 20),
                    PasswordEditText(
                      showText: showText,
                      hint: AppLocalizations.of(context)!.password,
                      inputType: TextInputType.number,
                      controller: passwordcontroller,
                      autofillHint: const [AutofillHints.password],
                      onPressed: showPassword,
                      onEditComplete: () => TextInput.finishAutofillContext(),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SignButton(
                              buttoncolor: Colors.blue,
                              textcolor: Colors.white,
                              buttonText: AppLocalizations.of(context)!.login,
                              onPressed: () async {
                                AuthService().signin(
                                    emailcontroller.text.trim(),
                                    passwordcontroller.text.trim(),
                                    context,
                                    formKey);
                              },
                              iconData: Icons.lock),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration:BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(15) ) ,
                              child: IconButton(
                                  onPressed: ()async {
                                    final isAuthentication =await LocalAuthApi.authenticate();
                                    if(isAuthentication){
                                      navigatorKey.currentState!.pushReplacementNamed(HomeScreen.routeName);
                                    }
                                  },
                                  icon: const Icon(Icons.fingerprint)),
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 20),
                      child: GestureDetector(
                        child:  Text(
                          AppLocalizations.of(context)!.forgotpassword,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen()));
                        },
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignUp,
                              text: AppLocalizations.of(context)!.signup,
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue))
                        ])),
                    const SizedBox(height: 20,),
                    const Divider(color: Colors.grey,height: 20,),

                    SignButton(
                      buttoncolor: Colors.white,
                      textcolor: Colors.blue,
                      buttonText: "${AppLocalizations.of(context)!.signup} Google",
                      onPressed: () {
                        Provider.of<AuthProvider>(context,listen: false).googleLogIn();
                      },
                      iconData: FontAwesomeIcons.google,

                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
}
