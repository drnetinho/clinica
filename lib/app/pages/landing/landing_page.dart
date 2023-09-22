import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/landing/pages/landing_page_mobile.dart';
import 'package:netinhoappclinica/app/pages/landing/pages/landing_page_web.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/landing';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

//PEGAR TAMANHO DA TELA PRA O WIDGET LANDINPAGE SER WEB OU MOBILE
bool getWebOrMobileSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 800) {
    return true;
  } else {
    return false;
  }
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorsApp.whiteColor,
      body: getWebOrMobileSize(context) ? const LandingPageWeb() : const LandingPageMobile(),
    );
  }
}
