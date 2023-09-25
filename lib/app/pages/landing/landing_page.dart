import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/app_bar_landing_page.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/go_login_admin.dart';
import '../../../core/components/medical_scale_card_widget.dart';
import '../../../core/components/wallet_Cpf_widget.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/landing';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorsApp.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                const AppBarLandingPage(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const GoLoginAdmin(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const WalletCPFWidget(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                const MedicalScaleCardWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
