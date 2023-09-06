import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/editar_buttons.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/list_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../../core/components/app_dialog.dart';
import '../../../../../core/components/app_form_field.dart';
import '../../../../../core/helps/spacing.dart';
import '../store/edit_patient_store.dart';
import 'excluir_buttons.dart';

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
    controller.setupConfig(widget.patient);
    if (widget.patient.previousIlnesses.noNull) {
      controller.ilnesses.value = widget.patient.previousIlnesses!;
    }
  }

  @override
  void didUpdateWidget(covariant FichaMedicaWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.setupConfig(widget.patient);
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
                            onPressedSecond: () => widget.editStore.updatePatient(
                              patient: controller.updatePatient(),
                            ),
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
                    if (isEditing) ...{
                      SizedBox(
                        height: 80,
                        width: 250,
                        // TODO Thiago Customizar o DropdownButtonFormField para ficar semelhante ao AppFormField (basta copiar o decoration do AppFormField e por aqui)
                        child: ValueListenableBuilder(
                          valueListenable: controller.selectedGender,
                          builder: (context, gender, child) {
                            return DropdownButtonFormField<String>(
                              value: gender.isNotEmpty ? gender : null,
                              hint: const Text('Selecione uma opção'),
                              isExpanded: true,
                              items: controller.genderList
                                  .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (v) => v != null ? controller.setGender = v : null,
                            );
                          },
                        ),
                      ),
                    } else ...{
                      AppFormField(
                        readOnly: !isEditing,
                        labelText: 'Sexo:',
                        controller: controller.genderCt,
                      ),
                    },
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Doenças Pré-Existentes',
                        style: context.textStyles.textPoppinsMedium
                            .copyWith(fontSize: 16, color: context.colorsApp.success),
                      ),
                      ValueListenableBuilder(
                        valueListenable: controller.ilnesses,
                        builder: (context, value, _) {
                          return ListView.builder(
                            itemCount: value.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final illness = value[index];
                              return Row(
                                children: [
                                  Text(
                                    '- $illness',
                                    style: context.textStyles.textPoppinsMedium
                                        .copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                                  ),
                                  Spacing.s.horizotalGap,
                                  Visibility(
                                    visible: isEditing,
                                    child: GestureDetector(
                                      onTap: () => controller.removeIlness = illness,
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      Visibility(
                        visible: isEditing,
                        child: ValueListenableBuilder(
                          valueListenable: controller.showIlnessField,
                          builder: (context, showField, _) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 40),
                                GestureDetector(
                                  onTap: () => controller.showIlnessField.value = true,
                                  child: Text(
                                    'Adicionar Doença',
                                    style: context.textStyles.textPoppinsMedium
                                        .copyWith(fontSize: 16, color: context.colorsApp.success),
                                  ),
                                ),
                                if (showField)
                                  AppFormField(
                                    maxHeight: 60,
                                    controller: controller.ilnessCt,
                                    onSubmit: controller.onSubmitIlness,
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 125),
                Expanded(
                  child: Column(
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
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
