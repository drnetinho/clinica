import 'package:clisp/app/pages/avaliacoes/domain/model/avaliation.dart';
import 'package:clisp/app/pages/avaliacoes/view/ready_avaliation_page.dart';
import 'package:clisp/app/pages/historico/widgets/historic_avaliation_card.dart';
import 'package:clisp/app/pages/home/view/home_page.dart';
import 'package:clisp/app/root/router_controller.dart';
import 'package:flutter/material.dart';

import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/components/drop_filter.dart';
import '../../../../core/components/store_builder.dart';
import '../../avaliacoes/view/store/avaliations_store.dart';

class HistoricPatientCardList extends StatefulWidget {
  final PatientModel patient;
  final GetAvaliationsStore store;
  const HistoricPatientCardList({
    Key? key,
    required this.patient,
    required this.store,
  }) : super(key: key);

  @override
  State<HistoricPatientCardList> createState() => _HistoricPatientCardListState();
}

class _HistoricPatientCardListState extends State<HistoricPatientCardList> {
  @override
  void initState() {
    super.initState();
 
    widget.store.getPatientAvaliations(patientId: widget.patient.id);
  }

  @override
  void didUpdateWidget(covariant HistoricPatientCardList oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.store.getPatientAvaliations(patientId: widget.patient.id);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      width: MediaQuery.of(context).size.width * .42,
      child: Stack(
        children: [
          PhysicalModel(
            elevation: 10,
            color: context.colorsApp.backgroundCardColor,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(34, 28, 34, 22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lista de Consultas',
                        style: context.textStyles.textPoppinsSemiBold.copyWith(
                          fontSize: 20,
                          color: context.colorsApp.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      width: MediaQuery.of(context).size.width * .42,
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colorsApp.backgroundCardColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: StoreBuilder<List<Avaliation>>(
                          store: widget.store,
                          validateEmptyList: true,
                          validateDefaultStates: true,
                          builder: (context, avaliations, _) {
                            return ListView.builder(
                              itemCount: avaliations.length,
                              itemBuilder: (context, index) {
                                final Avaliation avaliation = avaliations[index];
                                return HistoricAvaliationCard(
                                  avaliation: avaliation,
                                  onDetailPressed: () {
                                    context.go(
                                      subRoute(
                                        HomePage.routeName,
                                        ReadyAvaliationPage.routeName,
                                      ),
                                      extra: ReadyAvaliationPageArgs(
                                        avaliation: avaliation,
                                        patient: widget.patient,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 25,
            right: 20,
            child: DropFilter(
              selectedValue: (p0) {},
            ),
          ),
        ],
      ),
    );
  }
}
