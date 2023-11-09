import 'package:flutter/material.dart';
import 'package:clisp/common/state/app_state_extension.dart';

import 'package:clisp/core/helps/extension/string_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:clisp/di/get_it.dart';

import '../../../../../core/components/store_builder.dart';
import '../../../../../core/helps/actual_date.dart';
import '../../../grupo_familiar/domain/model/family_group_model.dart';
import '../../../grupo_familiar/domain/model/family_payment_model.dart';
import '../../../grupo_familiar/view/controller/filter_controller.dart';
import '../../../grupo_familiar/view/store/get_group_payments_store.dart';

class GroupTile extends StatefulWidget {
  final FamilyGroupModel group;
  final String filter;

  const GroupTile({
    Key? key,
    required this.group,
    required this.filter,
  }) : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  late final GetGroupPaymentsStore getGroupPaymentsStore;
  late final FilterController filterController;
  @override
  void initState() {
    super.initState();

    filterController = getIt<FilterController>();
    getGroupPaymentsStore = getIt<GetGroupPaymentsStore>();
    getGroupPaymentsStore.getGroupPayments(id: widget.group.id);
  }

  @override
  void didUpdateWidget(covariant GroupTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (getGroupPaymentsStore.value.isSuccess) {
      getGroupPaymentsStore.emmitFilteredPayments(
        filterController.filterPayments(
          getGroupPaymentsStore.allGroupPayments.value,
          widget.filter,
          KCurrentDate,
        ),
      );
    }
  }

  @override
  void dispose() {
    getGroupPaymentsStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            subtitle: Text(
              'Membro'.formatPlural(widget.group.members.length),
              style: context.textStyles.textPoppinsRegular.copyWith(fontSize: 15),
            ),
            title: Text(
              widget.group.name,
              style: context.textStyles.textPoppinsRegular.copyWith(fontSize: 20),
            ),
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: context.colorsApp.whiteColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: context.colorsApp.primary, width: 2),
              ),
              child: Icon(Icons.family_restroom, color: context.colorsApp.primary, size: 20),
            ),
            trailing: StoreBuilder<List<FamilyPaymnetModel>>(
                store: getGroupPaymentsStore,
                validateDefaultStates: false,
                builder: (context, List<FamilyPaymnetModel> payments, _) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      getTextStatus(payments).toUpperCase(),
                      style: context.textStyles.textPoppinsRegular.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: getColorStatus(payments),
                        letterSpacing: 1.5,
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .28,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Divider(thickness: 1, color: context.colorsApp.greyColor),
            ),
          ),
        ],
      ),
    );
  }

  String getTextStatus(List<FamilyPaymnetModel> payments) {
    if (payments.isEmpty) {
      return 'A definir';
    } else {
      return getGroupPaymentsStore.isPending(payments) ? 'Pendente' : 'Pago';
    }
  }

  Color getColorStatus(List<FamilyPaymnetModel> payments) {
    if (payments.isEmpty) {
      return ColorsApp.instance.warning;
    } else {
      return getGroupPaymentsStore.isPending(payments) ? ColorsApp.instance.danger : ColorsApp.instance.primary;
    }
  }
}
