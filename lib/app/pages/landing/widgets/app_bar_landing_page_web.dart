import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../common/services/remote_config/remote_config_service.dart';
import '../../../../core/components/store_builder.dart';
import '../../../../di/get_it.dart';
import '../../home/domain/model/app_details_model.dart';
import '../../home/view/store/app_details_store.dart';

class AppBarLandingPageWeb extends StatefulWidget {
  const AppBarLandingPageWeb({
    super.key,
  });

  @override
  State<AppBarLandingPageWeb> createState() => _AppBarLandingPageWebState();
}

class _AppBarLandingPageWebState extends State<AppBarLandingPageWeb> {
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
    double unitHeight = MediaQuery.of(context).size.height * 0.001;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: RMConfig.instance.clispImage?.isNotEmpty == true
              ? CachedNetworkImage(imageUrl: RMConfig.instance.clispImage!)
              : Image.asset('assets/images/clinica_image.png'),
        ),
        StoreBuilder<AppDetailsModel>(
          store: _detailsStore,
          validateDefaultStates: false,
          builder: (context, appDetails, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appDetails.name,
                  style: context.textStyles.textPoppinsSemiBold
                      .copyWith(color: context.colorsApp.secondaryColorRed, fontSize: 28 * unitHeight),
                ),
                Text(
                  appDetails.address,
                  style: context.textStyles.textPoppinsSemiBold
                      .copyWith(color: context.colorsApp.greyColor, fontSize: 20 * unitHeight),
                ),
                Text(
                  'Telefone: ${appDetails.phone1}',
                  style: context.textStyles.textPoppinsSemiBold
                      .copyWith(color: context.colorsApp.greyColor2, fontSize: 20 * unitHeight),
                ),
                if (appDetails.phone2?.isNotEmpty == true)
                  Text(
                    'Telefone secundário: ${appDetails.phone2!}',
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(color: context.colorsApp.greyColor2, fontSize: 20 * unitHeight),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
