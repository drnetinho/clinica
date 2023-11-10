import 'package:flutter/material.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../core/components/store_builder.dart';
import '../../../../di/get_it.dart';
import '../../home/domain/model/app_details_model.dart';
import '../../home/view/store/app_details_store.dart';

class AppBarLandingPageMobile extends StatefulWidget {
  const AppBarLandingPageMobile({
    super.key,
  });

  @override
  State<AppBarLandingPageMobile> createState() => _AppBarLandingPageMobileState();
}

class _AppBarLandingPageMobileState extends State<AppBarLandingPageMobile> {
  late final AppDetailsStore _detailsStore;

  @override
  void initState() {
    super.initState();
    _detailsStore = getIt<AppDetailsStore>();
    _detailsStore.getDetails();
  }

  @override
  void dispose() {
    _detailsStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppDetailsModel>(
        store: _detailsStore,
        validateDefaultStates: false,
        builder: (context, appDetails, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                appDetails.name,
                style: context.textStyles.textPoppinsSemiBold.copyWith(
                  color: context.colorsApp.secondaryColorRed,
                  fontSize: 26,
                ),
                maxLines: 2,
              ),
              Text(
                appDetails.address,
                style:
                    context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.greyColor, fontSize: 14),
              ),
              Text(
                'Telefone: ${appDetails.phone1}',
                style:
                    context.textStyles.textPoppinsSemiBold.copyWith(color: context.colorsApp.greyColor2, fontSize: 12),
              ),
              if (appDetails.phone2?.isNotEmpty == true)
                Text(
                  'Telefone secundário: ${appDetails.phone2!}',
                  style: context.textStyles.textPoppinsSemiBold
                      .copyWith(color: context.colorsApp.greyColor2, fontSize: 12),
                ),
            ],
          );
        });
  }
}
