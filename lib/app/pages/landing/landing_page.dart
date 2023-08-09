import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/app_bar_landing_page.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/go_login_admin.dart';
import '../../core/components/consult_file_widget.dart';
import '../../core/components/medical_scale_card_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final cpfControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.colorsApp.whiteColor,
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
                const ConsultFileWidget(),
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
