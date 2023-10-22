import 'package:flutter/widgets.dart';
import 'package:netinhoappclinica/app/pages/home/domain/model/app_details_model.dart';
import 'package:netinhoappclinica/common/services/remote_config/remote_config_service.dart';
import 'package:netinhoappclinica/core/components/store_builder.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../store/app_details_store.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  double getwidth(BuildContext context) {
    // A largura nao pode ser menor que 600
    if (MediaQuery.of(context).size.width * 0.3 < 800) {
      return 800;
    } else {
      return MediaQuery.of(context).size.width * 0.3;
    }
  }

  double getheight(BuildContext context) {
    // A altura nao pode ser menor que 250
    if (MediaQuery.of(context).size.height * 0.2 < 250) {
      return 250;
    } else {
      return MediaQuery.of(context).size.height * 0.22;
    }
  }

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
    return SizedBox(
      width: getwidth(context),
      height: getheight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bem-vindo, Administrador', style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 28)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: RMConfig.instance.clispImage?.isNotEmpty == true
                    ? Image.network(RMConfig.instance.clispImage!)
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
                              .copyWith(color: context.colorsApp.secondaryColorRed, fontSize: 22),
                        ),
                        Text(
                          appDetails.address,
                          style: context.textStyles.textPoppinsSemiBold
                              .copyWith(color: context.colorsApp.greyColor, fontSize: 14),
                        ),
                        Text(
                          'Telefone: ${appDetails.phone1}',
                          style: context.textStyles.textPoppinsSemiBold
                              .copyWith(color: context.colorsApp.greyColor2, fontSize: 12),
                        ),
                        if (appDetails.phone2?.isNotEmpty == true)
                          Text(
                            'Telefone secundário: ${appDetails.phone2!}',
                            style: context.textStyles.textPoppinsSemiBold
                                .copyWith(color: context.colorsApp.greyColor2, fontSize: 12),
                          ),
                      ],
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
