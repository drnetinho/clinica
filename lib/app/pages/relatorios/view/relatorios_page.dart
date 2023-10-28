import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/controller/filter_controller.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/store/get_groups_store.dart';
import 'package:netinhoappclinica/app/pages/relatorios/view/store/get_payments_store.dart';
import 'package:netinhoappclinica/app/pages/relatorios/view/widgets/groups_card.dart';
import 'package:netinhoappclinica/app/pages/relatorios/view/widgets/info_card.dart';
import 'package:netinhoappclinica/app/pages/relatorios/view/widgets/percent_line_card.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/components/state_widget.dart';
import 'package:netinhoappclinica/core/components/store_builder.dart';
import 'package:netinhoappclinica/core/helps/actual_date.dart';
import 'package:netinhoappclinica/core/helps/padding.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../clinica_icons_icons.dart';
import '../../../../core/components/drop_filter.dart';
import '../../../../core/helps/filter.dart';
import '../../../../di/get_it.dart';
import '../../grupo_familiar/domain/model/family_group_model.dart';
import '../../grupo_familiar/domain/model/family_payment_model.dart';

class RelatoriosPage extends StatefulWidget {
  static const String routeName = 'relatorios';
  const RelatoriosPage({super.key});

  @override
  State<RelatoriosPage> createState() => _RelatoriosPageState();
}

class _RelatoriosPageState extends State<RelatoriosPage> with SnackBarMixin {
  late final GetGroupsStore getGroupsStore;
  late final GetRelatoriosPaymentsStore getPaymentsStore;
  late final FilterController filterController;
  late final ValueNotifier<String> currentFilter;

  @override
  void initState() {
    super.initState();
    getGroupsStore = getIt<GetGroupsStore>();
    filterController = getIt<FilterController>();
    getPaymentsStore = getIt<GetRelatoriosPaymentsStore>();
    if (!getPaymentsStore.value.isSuccess) {
      getPaymentsStore.getPendingPayments();
    }
    if (!getGroupsStore.value.isSuccess) {
      getGroupsStore.getGroups();
    }

    currentFilter = ValueNotifier(FilterStrings.todos);
  }

  void fetchData() {
    getGroupsStore.getGroups();
    getPaymentsStore.getPendingPayments();
  }

  @override
  void dispose() {
    currentFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(110, 30, 110, 10),
        child: Stack(
          children: [
            Row(
              children: [
                Text(
                  'Relatórios de Fatuamento',
                  style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
                ),
              ],
            ),
            Container(
              margin: Padd.only(t: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StoreBuilder<List<FamilyGroupModel>>(
                    store: getGroupsStore,
                    validateDefaultStates: false,
                    builder: (context, List<FamilyGroupModel> groups, _) {
                      return AnimatedBuilder(
                          animation: Listenable.merge(
                            [currentFilter],
                          ),
                          builder: (context, _) {
                            return StoreBuilder(
                                store: getPaymentsStore,
                                validateDefaultStates: false,
                                builder: (context, List<FamilyPaymnetModel> pendigPayments, _) {
                                  final total = groups.length;
                                  final pending = getPaymentsStore.getPending(groups, currentFilter.value);
                                  final receive = total - pending - getPaymentsStore.undefiniedGroupsPerFilter.value;

                                  bool isInvalid = pending == 0 && receive == 0;

                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height * .8,
                                    width: MediaQuery.of(context).size.width * .42,
                                    child: isInvalid
                                        ? const StateEmptyWidget(
                                            icon: Icons.payment,
                                            message: 'Nenhum pagamento encontrado. Altere o valor do filtro!',
                                          )
                                        : Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  InfoCard(
                                                    icon: ClinicaIcons.family,
                                                    title: 'Total',
                                                    info: total.toString(),
                                                    isLoading: getGroupsStore.value.isLoading,
                                                  ),
                                                  InfoCard(
                                                    icon: ClinicaIcons.money,
                                                    title: 'Pagos',
                                                    info: '$receive/$total',
                                                    isLoading: getGroupsStore.value.isLoading,
                                                  ),
                                                  InfoCard(
                                                    icon: ClinicaIcons.clockbaselinehistory,
                                                    title: 'Pendentes',
                                                    info: '$pending/$total',
                                                    isLoading: getGroupsStore.value.isLoading,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * .1),
                                              PercentLineCard(
                                                isLoading: getGroupsStore.value.isLoading,
                                                pending: pending,
                                                receive: receive,
                                                total: total - getPaymentsStore.undefiniedGroupsPerFilter.value,
                                              ),
                                            ],
                                          ),
                                  );
                                });
                          });
                    },
                  ),
                  const Spacer(),
                  //*** LISTA DE GRUPOS
                  StoreBuilder<List<FamilyGroupModel>>(
                    store: getGroupsStore,
                    validateDefaultStates: false,
                    builder: (context, List<FamilyGroupModel> groups, _) => AnimatedBuilder(
                      animation: currentFilter,
                      builder: (context, _) => GroupsCard(
                        groups: groups,
                        filter: currentFilter.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                AnimatedBuilder(
                  animation: getPaymentsStore.allPendingPayments,
                  builder: (context, _) {
                    return AnimatedBuilder(
                      animation: currentFilter,
                      builder: (context, _) {
                        return DropFilter(
                          currentFilter: currentFilter.value,
                          selectedValue: (filterValue) {
                            // Para cada filtro aplicado, reseta-se o número de grupos Indefinidos até que
                            // os pagamentos filtrados sejam processados novamente
                            getPaymentsStore.undefiniedGroupsPerFilter.value = 0;
                            currentFilter.value = filterValue;
                            final list = filterController.filter(
                              getPaymentsStore.allPendingPayments.value,
                              filterValue,
                              KCurrentDate,
                            );
                            getPaymentsStore.emmitFilteredPayments(list);
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
