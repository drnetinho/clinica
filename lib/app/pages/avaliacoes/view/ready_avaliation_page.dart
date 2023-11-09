import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:clisp/common/services/remote_config/remote_config_service.dart';
import 'package:clisp/common/state/app_state_extension.dart';
import 'package:clisp/core/components/app_loader.dart';
import 'package:flutter/material.dart';

import 'package:clisp/app/pages/avaliacoes/domain/model/avaliation.dart';
import 'package:clisp/app/pages/avaliacoes/view/widgets/ready_avaliation.dart';
import 'package:clisp/app/pages/doctors/view/store/doctor_store.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/components/snackbar.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:clisp/di/get_it.dart';

import 'controller/new_avaliation_controller.dart';

class ReadyAvaliationPageArgs {
  final Avaliation avaliation;
  final PatientModel patient;
  ReadyAvaliationPageArgs({
    required this.avaliation,
    required this.patient,
  });
}

class ReadyAvaliationPage extends StatefulWidget {
  final ReadyAvaliationPageArgs? args;

  static const String routeName = 'avaliacao';

  const ReadyAvaliationPage({
    Key? key,
    this.args,
  }) : super(key: key);

  @override
  State<ReadyAvaliationPage> createState() => _ReadyAvaliationPageState();
}

class _ReadyAvaliationPageState extends State<ReadyAvaliationPage> with SnackBarMixin {
  late final GetDoctorStore _getDoctorStore;

  late final NewAvaliationController controller;

  @override
  void initState() {
    super.initState();

    controller = getIt<NewAvaliationController>();
    _getDoctorStore = getIt<GetDoctorStore>();
    _getDoctorStore.getDoctorById(
      widget.args!.avaliation.doctorId,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _getDoctorStore.dispose();
    super.dispose();
  }

  bool get isReadyMode => widget.args != null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 40),
              child: Text(
                'Visualizar Avaliação',
                style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
              ),
            ),
            const SizedBox(height: 50),
            ValueListenableBuilder(
              valueListenable: _getDoctorStore,
              builder: (context, state, _) {
                if (state.isSuccess) {
                  return ReadyAvaliation(
                    doctor: _getDoctorStore.value.success.data as Doctor,
                    avaliation: widget.args!.avaliation,
                    patient: widget.args!.patient,
                    controller: controller,
                  );
                }
                if (state.isError) {
                  return ReadyAvaliation(
                    doctor: Doctor(
                      widget.args!.avaliation.doctorName,
                      'Médico Excluído',
                      RMConfig.instance.emptyAvatar,
                      '',
                    ),
                    avaliation: widget.args!.avaliation,
                    patient: widget.args!.patient,
                    controller: controller,
                  );
                }
                return const Center(child: AppLoader());
              },
            ),
          ],
        ),
      ),
    );
  }
}
