import 'package:flutter/material.dart';
import 'package:clisp/app/pages/landing/widgets/app_bar_landing_page_mobile.dart';
import 'package:clisp/app/pages/landing/widgets/image_logo_mobile.dart';

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
    oneSec.sleep.then((value) => scrollTo());
  }

  void scrollTo({bool end = false}) {
    final offset = end ? _scrollController.position.maxScrollExtent : _scrollController.position.maxScrollExtent * 0.5;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: AppBarLandingPageMobile(),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ImageLogoMobile(),
            ),
            const SizedBox(height: 30),
            WalletCpfWidgetMobile(
              onFindGroup: scrollTo,
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: MedicalScaleCardWidgetMobile(),
            )
          ],
        ),
      ),
    );
  }
}
