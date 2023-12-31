import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:clisp/app/pages/formas_pagamento/domain/model/pix_model.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:clisp/app/pages/landing/controller/wallet_controller.dart';
import 'package:clisp/common/services/remote_config/remote_config_service.dart';
import 'package:clisp/core/components/app_loader.dart';
import 'package:clisp/core/components/store_builder.dart';
import 'package:clisp/core/helps/duration.dart';
import 'package:clisp/core/helps/extension/date_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../app/pages/formas_pagamento/view/store/get_pix_store.dart';
import '../../app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import '../../app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import '../../app/pages/grupo_familiar/view/store/get_group_members_store.dart';
import '../../app/pages/grupo_familiar/view/store/get_group_payments_store.dart';
import '../../di/get_it.dart';
import '../helps/spacing.dart';

class WalletDetails extends StatefulWidget {
  final FamilyGroupModel group;
  final bool fromMobile;

  const WalletDetails({
    super.key,
    required this.group,
    this.fromMobile = false,
  });

  @override
  State<WalletDetails> createState() => _WalletDetailsState();
}

class _WalletDetailsState extends State<WalletDetails> {
  late final GetGroupMembersStore _getGroupMembersStore;
  late final GetGroupPaymentsStore paymnetsStore;
  late final WalletController walletController;
  late final GetPixStore getPixStore;

  @override
  void initState() {
    super.initState();
    paymnetsStore = getIt<GetGroupPaymentsStore>();
    _getGroupMembersStore = getIt<GetGroupMembersStore>();
    walletController = getIt<WalletController>();
    getPixStore = getIt<GetPixStore>();
    getPixStore.getPix();

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

  String getNameAndSurname(String name) {
    final names = name.split(' ');
    return '${names[0]} ${names[names.length - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: widget.fromMobile == false,
              child: IconButton(
                onPressed: () => walletController.isFlipped.value = !walletController.isFlipped.value,
                icon: Icon(
                  walletController.isFlipped.value ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                  color: context.colorsApp.greenDark2,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: walletController.isFlipped,
              builder: (context, _) {
                return StoreBuilder<List<PatientModel>>(
                  store: _getGroupMembersStore,
                  validateDefaultStates: true,
                  loading: const AppLoader(primary: false),
                  builder: (context, members, _) {
                    return AnimatedCrossFade(
                      duration: threeHundMili,
                      crossFadeState:
                          walletController.isFlipped.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      firstChild: GestureDetector(
                        onTap: () => walletController.isFlipped.value = true,
                        child: Container(
                          height: widget.fromMobile
                              ? MediaQuery.of(context).size.height * 0.28
                              : MediaQuery.of(context).size.height * 0.36,
                          width: widget.fromMobile
                              ? MediaQuery.of(context).size.width * 0.83
                              : MediaQuery.of(context).size.height * 0.6,
                          padding: EdgeInsets.all(widget.fromMobile ? 15 : 20),
                          decoration: BoxDecoration(
                            color: context.colorsApp.greenDark2,
                            borderRadius: BorderRadius.circular(12),
                            gradient: context.colorsApp.greenGradient,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.family_restroom,
                                    size: widget.fromMobile ? 40 : 60,
                                    color: context.colorsApp.dartWhite,
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Carteira Clisp',
                                        style: context.textStyles.textPoppinsBold.copyWith(
                                            fontSize: widget.fromMobile ? 18 : 24, color: context.colorsApp.dartWhite),
                                      ),
                                      Text(
                                        getNameAndSurname(widget.group.name),
                                        style: context.textStyles.textPoppinsBold.copyWith(
                                            fontSize: widget.fromMobile ? 14 : 18, color: context.colorsApp.greenDark),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Spacing.xs.verticalGap,
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: members.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 0.5,
                                        childAspectRatio: 16 / 5,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              members[index].name,
                                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                                  fontSize: widget.fromMobile ? 10 : 14,
                                                  color: context.colorsApp.dartWhite),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'CPF: ${members[index].cpf}',
                                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                                  fontSize: widget.fromMobile ? 8 : 10,
                                                  color: context.colorsApp.greenDark),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        );
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      secondChild: GestureDetector(
                        onTap: () => walletController.isFlipped.value = false,
                        child: Container(
                          height: widget.fromMobile
                              ? MediaQuery.of(context).size.height * 0.28
                              : MediaQuery.of(context).size.height * 0.36,
                          width: widget.fromMobile
                              ? MediaQuery.of(context).size.width * 0.83
                              : MediaQuery.of(context).size.height * 0.6,
                          decoration: BoxDecoration(
                            color: context.colorsApp.greenDark2,
                            borderRadius: BorderRadius.circular(12),
                            gradient: context.colorsApp.greenGradient,
                          ),
                          padding: EdgeInsets.all(widget.fromMobile ? 8 : 20),
                          child: StoreBuilder<List<FamilyPaymnetModel>>(
                            store: paymnetsStore,
                            validateDefaultStates: false,
                            builder: (context, payments, _) {
                              final payment = paymnetsStore.actualPendingPayment(payments);

                              return StoreBuilder<PixModel>(
                                  store: getPixStore,
                                  validateDefaultStates: false,
                                  builder: (context, pix, _) {
                                    return Center(
                                      child: pix.urlImage?.isNotEmpty == true
                                          ? Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: pix.urlImage ?? RMConfig.instance.pixQrCode ?? '',
                                                  height: widget.fromMobile ? 100 : 150,
                                                  width: widget.fromMobile ? 100 : 150,
                                                ),
                                                SizedBox(height: widget.fromMobile ? 10 : 20),
                                                Text(
                                                  'Chave Pix: ${pix.pixKey}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.75,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                if (payment != null) ...{
                                                  SizedBox(height: widget.fromMobile ? 10 : 20),
                                                  Text(
                                                    'Pagamento pendente: ${payment.payDate.formatted}',
                                                    style: TextStyle(
                                                      fontSize: widget.fromMobile ? 10 : 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                },
                                              ],
                                            )
                                          : const Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Nenhum QR Code cadastrado!\nEntre em contato com o administrador para obter informações de pagamento.',
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                // SizedBox(height: widget.fromMobile ? 10 : 20),
                                                // ElevatedButton(
                                                //   onPressed: () {
                                                //     // Levar pro whatsapp
                                                //   },
                                                //   child: const Text('Falar com o administrador'),
                                                // ),
                                              ],
                                            ),
                                    );
                                  });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Visibility(
              visible: widget.fromMobile == false,
              child: IconButton(
                onPressed: () => walletController.isFlipped.value = !walletController.isFlipped.value,
                icon: Icon(
                  walletController.isFlipped.value ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                  color: context.colorsApp.greenDark2,
                ),
              ),
            )
          ],
        ),
        Visibility(
          visible: widget.fromMobile == true,
          child: Spacing.xs.verticalGap,
        ),
        Visibility(
          visible: widget.fromMobile == true,
          child: AnimatedBuilder(
              animation: walletController.isFlipped,
              builder: (context, _) {
                return TextButton(
                  onPressed: () => walletController.isFlipped.value = !walletController.isFlipped.value,
                  child: Text(
                    walletController.isFlipped.value ? 'Voltar' : 'Ver QR Code',
                    style: context.textStyles.textPoppinsSemiBold.copyWith(
                      fontSize: 12,
                      color: context.colorsApp.blackColor,
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
