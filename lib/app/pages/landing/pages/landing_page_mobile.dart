import 'package:flutter/material.dart';
import '../../../../core/components/consult_file_widget_mobile.dart';
import '../../../../core/components/medical_scale_card_widget_mobile.dart';
import '../widgets/app_bar_landing_page_mobile.dart';
import '../widgets/go_login_admin_mobile.dart';

class LandingPageMobile extends StatefulWidget {
  const LandingPageMobile({super.key});

  @override
  State<LandingPageMobile> createState() => _LandingPageMobileState();
}

class _LandingPageMobileState extends State<LandingPageMobile> {
  final cpfControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarLandingPageMobile(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const GoLoginAdminMobile(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ConsultFileWidgetMobile(cpfControlller: cpfControlller),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const MedicalScaleCardWidgetMobile()
            ],
          ),
        ),
      ),
    );
  }
}
