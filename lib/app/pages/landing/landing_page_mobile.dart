import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/app_bar_landing_page_mobile.dart';
import 'package:netinhoappclinica/app/pages/landing/widgets/go_login_admin_mobile.dart';

import '../../../core/components/medical_scale_card_widget_mobile.dart';
import '../../../core/components/wallet_cpf_widget_mobile.dart';
import '../../../core/helps/duration.dart';

class LandingPageMobile extends StatefulWidget {
  const LandingPageMobile({super.key});

  @override
  State<LandingPageMobile> createState() => _LandingPageMobileState();
}

class _LandingPageMobileState extends State<LandingPageMobile> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    oneSec.sleep.then(
      (value) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarLandingPageMobile(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const GoLoginAdminMobile(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const WalletCpfWidgetMobile(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const MedicalScaleCardWidgetMobile()
            ],
          ),
        ),
      ),
    );
  }
}
