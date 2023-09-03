import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/store/patients_store.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/editar_buttons.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../../core/components/app_dialog.dart';
import '../../../../../core/components/app_form_field.dart';
import 'excluir_buttons.dart';

enum FichaMedicaState { edit, view, add }

class FichaMedicaWidget extends StatefulWidget {
  final PatientModel patient;
  final EditPatientsStore editStore;
  final ManagePatientsStore manageStore;

  const FichaMedicaWidget({
    Key? key,
    required this.patient,
    required this.editStore,
    required this.manageStore,
  }) : super(key: key);

  @override
  State<FichaMedicaWidget> createState() => _FichaMedicaWidgetState();
}

class _FichaMedicaWidgetState extends State<FichaMedicaWidget> {
  late final ValueNotifier<bool> editMode;
  late final FichaMedicaController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<FichaMedicaController>();

    editMode = ValueNotifier(false);
    controller.updateControllers(widget.patient);
  }

  @override
  void didUpdateWidget(covariant FichaMedicaWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.updateControllers(widget.patient);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: editMode,
        builder: (context, isEditing, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Ficha Médica', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 22)),
                  const Spacer(),
                  ExcluirButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          // TODO Thiago: Ajustar visualmente componente genérico de dialog
                          return AppDialog(
                            title: 'Deseja Realmente excluir paciente?',
                            firstButtonText: 'Cancelar',
                            secondButtonText: 'Excluir',
                            firstButtonIcon: Icons.cancel,
                            secondButtonIcon: Icons.delete,
                            store: widget.editStore,
                            onPressedSecond: () => widget.editStore.deletePatient(id: widget.patient.id),
                            actionOnSuccess: () => widget.manageStore.getPatients(),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  EditarButton(
                    isEditing: editMode.value,
                    isLoading: widget.editStore.value.isLoading,
                    onPressed: () {
                      if (isEditing) {
                        editMode.value = false;
                        showDialog(
                          context: context,
                          builder: (context) {
                            // TODO Thiago: Ajustar visualmente componente genérico de dialog
                            return AppDialog(
                              title: 'Deseja realmente salvar as alterações?',
                              firstButtonText: 'Cancelar',
                              secondButtonText: 'Salvar',
                              firstButtonIcon: Icons.cancel,
                              secondButtonIcon: Icons.check,
                              store: widget.editStore,
                              onPressedSecond: () {
                                widget.editStore.updatePatient(
                                  patient: controller.updatePatient(widget.patient),
                                );
                              },
                              actionOnSuccess: widget.manageStore.getPatients,
                            );
                          },
                        );
                      } else {
                        editMode.value = true;
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Dados Pessoais',
                style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.success),
              ),
              Text(
                widget.patient.name,
                style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.success),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFormField(
                        labelText: 'Nome:',
                        controller: controller.nameCt,
                        readOnly: !isEditing,
                      ),
                      const SizedBox(height: 10),
                      AppFormField(
                        readOnly: !isEditing,
                        labelText: 'Sexo:',
                        controller: controller.genderCt,
                      ),
                    ],
                  ),
                  const SizedBox(width: 150),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFormField(
                        readOnly: !isEditing,
                        labelText: 'Idade:',
                        controller: controller.ageCt,
                      ),
                      const SizedBox(height: 10),
                      AppFormField(
                        readOnly: !isEditing,
                        labelText: 'Contato:',
                        controller: controller.phoneCt,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Endereço',
                style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: context.colorsApp.success),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFormField(
                        readOnly: !isEditing,
                        labelText: 'Cidade:',
                        controller: controller.cityCt,
                      ),
                      const SizedBox(height: 10),
                      AppFormField(
                        readOnly: !isEditing,
                        labelText: 'Bairro:',
                        controller: controller.neighCt,
                      ),
                    ],
                  ),
                  const SizedBox(width: 180),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFormField(
                        readOnly: !isEditing,
                        labelText: 'Rua:',
                        controller: controller.streetCt,
                      ),
                      const SizedBox(height: 10),
                      AppFormField(
                        readOnly: !isEditing,
                        labelText: 'Número:',
                        controller: controller.numberCt,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Doenças Pré-Existentes',
                        style: context.textStyles.textPoppinsMedium
                            .copyWith(fontSize: 16, color: context.colorsApp.success),
                      ),
                      AppFormField(
                        readOnly: !isEditing,
                        maxLines: 1,
                        controller: controller.ilnessCt,
                      ),
                      if (widget.patient.previousIlnesses != null) ...{
                        ...widget.patient.previousIlnesses!.map(
                          (illness) => Text(
                            illness,
                            style: context.textStyles.textPoppinsMedium
                                .copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                          ),
                        ),
                      },
                    ],
                  ),
                  const SizedBox(width: 125),
                  Column(
                    children: [
                      Text(
                        'Grupo Familiar',
                        style: context.textStyles.textPoppinsMedium
                            .copyWith(fontSize: 16, color: context.colorsApp.success),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.patient.familyGroup,
                        style: context.textStyles.textPoppinsMedium
                            .copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }
}
