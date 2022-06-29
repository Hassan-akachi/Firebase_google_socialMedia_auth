import 'package:dummy_trade/model/auth_services.dart';
import 'package:dummy_trade/widgets/custom_edittext_box.dart';
import 'package:dummy_trade/widgets/sign_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = "ForgetPassWord-Screen";
  static final formKey = GlobalKey<FormState>();

  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Reset Password",style: TextStyle(fontSize: 20),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [const Text("send the new password to \n your email",style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20,),
                AutofillGroup(
                  child: EmailEditText(
                      hint: "type your email",
                      inputType: TextInputType.emailAddress,
                      controller: emailcontroller,
                  autofillHints: const [AutofillHints.email],),
                ),
                const SizedBox(height: 20,),
                SignButton(
                    buttoncolor: Colors.blue,
                    textcolor: Colors.white,
                    buttonText: "Reset Password",
                    onPressed: () async {
                      AuthService().passwordReset(emailcontroller.text.trim(), context);
                    },
                    iconData: Icons.lock_open),
              ],
            ),
          ),
        ));
  }
}
