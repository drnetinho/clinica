// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:netinhoappclinica/common/form/inputs.dart';
import 'package:netinhoappclinica/core/components/app_form_field.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/helps/duration.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../common/services/auth/auth_service.dart';
import '../../../di/get_it.dart';

class SignPage extends StatefulWidget {
  static const String routeName = '/sign';
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> with SnackBarMixin {
  final TextEditingController emailCtrl = TextEditingController(text: 'drnetinhoclisp@gmail.com');

  final TextEditingController passCtrl = TextEditingController(text: 'Appclinica1');

  late final AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = getIt<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/landing_bg.jpeg'),
              ),
            ),
          ),
          Center(
            child: PhysicalModel(
              borderRadius: BorderRadius.circular(12),
              elevation: 10,
              color: context.colorsApp.whiteColor.withOpacity(.9),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.38,
                height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Entrar',
                        style: context.textStyles.textPoppinsBold.copyWith(
                          fontSize: 38,
                          color: context.colorsApp.primary,
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: AnimatedBuilder(
                        animation: emailCtrl,
                        builder: (context, _) {
                          return AppFormField(
                            maxHeight: 70,
                            controller: emailCtrl,
                            validator: (text) {
                              if (text != null && text.isValidEmail) {
                                return null;
                              } else {
                                return EmailInputError.invalid.exists;
                              }
                            },
                            isValid: emailCtrl.text.isValidEmail,
                            errorText: emailCtrl.text.isValidEmail ? null : EmailInputError.invalid.message,
                            labelText: 'Email',
                          );
                        },
                      ),
                    ),
                    AnimatedBuilder(
                      animation: passCtrl,
                      builder: (context, _) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: AppFormField(
                            maxHeight: 70,
                            controller: passCtrl,
                            validator: (text) {
                              if (text != null && text.hasMinimumLength) {
                                return null;
                              } else {
                                return StringInputError.empty.exists;
                              }
                            },
                            isValid: passCtrl.text.hasMinimumLength,
                            errorText: passCtrl.text.hasMinimumLength ? null : StringInputError.empty.password,
                            labelText: 'Senha',
                            helperText: 'Mínimo de 6 caracteres',
                          ),
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: handleSignin,
                        child: const Text('Acessar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleSignin() async {
    final result = await authService.signIn(
      email: emailCtrl.text,
      password: passCtrl.text,
    );
    if (result.error != null) {
      showError(
        context: context,
        text: result.error!,
      );
    }

    if (result.userCredential != null) {
      showSuccess(
        context: context,
        text: 'Login realizado com sucesso!',
      );
      await oneSec.sleep;
      getIt<AuthService>().isLogged.value = true;
    }
  }
}
