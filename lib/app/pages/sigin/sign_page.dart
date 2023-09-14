import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../core/components/input_field.dart';
import '../home/view/home_page.dart';

class SignPage extends StatelessWidget {
  static const String routeName = '/sign';
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Entrar', style: context.textStyles.textPoppinsBold.copyWith(fontSize: 28)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: InputField(
                    controller: emailController,
                    labelTextBorder: 'Email',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: InputField(
                    controller: passwordController,
                    labelTextBorder: 'Senha',
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        context.go(HomePage.routeName);
                      },
                      child: const Text('Entrar')),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Image.asset('assets/images/image_login.png', fit: BoxFit.cover),
        ),
      ],
    ));
  }
}
