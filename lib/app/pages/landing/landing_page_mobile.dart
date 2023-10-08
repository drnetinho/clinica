import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/app_bar_landing_page_mobile.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/go_login_admin_mobile.dart';

import '../../../core/components/medical_scale_card_widget_mobile.dart';
import '../../../core/components/wallet_cpf_widget_mobile.dart';


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
              WalletCpfWidgetMobile(cpfControlller: cpfControlller),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const MedicalScaleCardWidgetMobile()
            ],
          ),
        ),
      ),
    );
  }
}
