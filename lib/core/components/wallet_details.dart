import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/common/services/remote_config/remote_config_service.dart';
import 'package:netinhoappclinica/core/components/app_loader.dart';
import 'package:netinhoappclinica/core/components/store_builder.dart';
import 'package:netinhoappclinica/core/helps/duration.dart';
import 'package:netinhoappclinica/core/helps/extension/date_extension.dart';

import '../../app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import '../../app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import '../../app/pages/grupo_familiar/view/store/get_group_members_store.dart';
import '../../app/pages/grupo_familiar/view/store/get_group_payments_store.dart';
import '../../di/get_it.dart';
import 'animated_resize.dart';

class WalletDetails extends StatefulWidget {
  final FamilyGroupModel group;

  const WalletDetails({
    super.key,
    required this.group,
  });

  @override
  State<WalletDetails> createState() => _WalletDetailsState();
}

class _WalletDetailsState extends State<WalletDetails> {
  late final GetGroupMembersStore _getGroupMembersStore;
  late final GetGroupPaymentsStore paymnetsStore;

  @override
  void initState() {
    super.initState();
    paymnetsStore = getIt<GetGroupPaymentsStore>();
    _getGroupMembersStore = getIt<GetGroupMembersStore>();

    _getGroupMembersStore.getGroupMembers(
      ids: widget.group.members,
    );
    paymnetsStore.getGroupPayments(
      id: widget.group.id,
    );
  }

  @override
  void dispose() {
    _getGroupMembersStore.dispose();
    paymnetsStore.dispose();
    super.dispose();
  }

  final ValueNotifier<bool> isFlipped = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: isFlipped,
      builder: (context, _) {
        return AnimatedCrossFade(
          duration: threeHundMili,
          crossFadeState: isFlipped.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: GestureDetector(
            onTap: () => isFlipped.value = true,
            child: AnimatedResize(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Group.png'),
                  ),
                ),
                child: Center(
                  child: StoreBuilder<List<PatientModel>>(
                    store: _getGroupMembersStore,
                    validateDefaultStates: true,
                    loading: const AppLoader(primary: false),
                    builder: (context, members, _) {
                      return Wrap(
                        children: members
                            .map(
                              (member) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(member.name),
                                    Text(member.cpf),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () => isFlipped.value = false,
            child: AnimatedResize(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Group.png'),
                  ),
                ),
                child: StoreBuilder<List<FamilyPaymnetModel>>(
                    store: paymnetsStore,
                    validateDefaultStates: false,
                    builder: (context, payments, _) {
                      final payment = paymnetsStore.actualPendingPayment(payments);
                      return Center(
                        child: RMConfig.instance.pixQrCode?.isNotEmpty == true
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    RMConfig.instance.pixQrCode!,
                                    height: 200,
                                    width: 200,
                                  ),
                                  if (payment != null) Text('Pagamento pendente: ${payment.payDate.formatted}'),
                                ],
                              )
                            : Column(
                                children: [
                                  const Text('Nenhum QR Code cadastrado, entre em contato com o administrador.'),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Levar pro whatsapp
                                    },
                                    child: const Text('Falar com o administrador'),
                                  ),
                                ],
                              ),
                      );
                    }),
              ),
            ),
          ),
        );
      },
    );
  }
}
