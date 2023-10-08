import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/app_bar_landing_page_web.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/go_login_admin_web.dart';

import '../../../core/components/medical_scale_card_widget_web.dart';
import '../../../core/components/wallet_cpf_widget_web.dart';

class LandingPageWeb extends StatelessWidget {
  const LandingPageWeb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              const AppBarLandingPageWeb(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const GoLoginAdminWeb(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const WalletCPFWidgetWeb(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              const MedicalScaleCardWidgetWeb(),
            ],
          ),
        ),
      ),
    );
  }
}
