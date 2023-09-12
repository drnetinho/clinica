import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/editar_buttons.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../../common/form/app_formatters.dart';
import '../../../../../core/components/app_dialog.dart';
import '../../../../../core/components/app_form_field.dart';
import '../../../../../core/helps/spacing.dart';
import '../controller/gerenciar_pacientes_controller.dart';
import '../controller/new_patient_form_controller.dart';
import '../forms/new_patient_form.dart';
import '../store/edit_patient_store.dart';
import 'excluir_buttons.dart';

class NewPatientFormWidget extends StatefulWidget {
  final EditPatientsStore editStore;
  final ManagePatientsStore manageStore;

  const NewPatientFormWidget({
    Key? key,
    required this.editStore,
    required this.manageStore,
  }) : super(key: key);

  @override
  State<NewPatientFormWidget> createState() => _NewPatientFormWidgetState();
}

class _NewPatientFormWidgetState extends State<NewPatientFormWidget> {
  late final ScrollController scrollController;
  late final ValueNotifier<bool> editMode;

  late final NewPatientFormController controller;
  late final GerenciarPacientesController gerenciarController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    controller = getIt<NewPatientFormController>();
    gerenciarController = getIt<GerenciarPacientesController>();
    editMode = ValueNotifier(true);
    controller.setFormListeners();
    controller.showIlnessField.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<NewPatinetForm>(
        valueListenable: controller.form,
        builder: (context, form, _) {
          return ValueListenableBuilder(
            valueListenable: editMode,
            builder: (context, isEditing, _) {
              return Scrollbar(
                thumbVisibility: true,
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Adicionar Paciente',
                              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 22)),
                          const Spacer(),
                          ExcluirButton(
                            discardMode: true,
                            onPressed: () {
                              toogleOffAddNewPatient();
                              controller.resetValues();
                            },
                          ),
                          const SizedBox(width: 10),
                          EditarButton(
                            isEditing: editMode.value,
                            isLoading: widget.editStore.value.isLoading,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AppDialog(
                                    title: 'Deseja realmente salvar as alterações?',
                                    firstButtonText: 'Cancelar',
                                    secondButtonText: 'Salvar',
                                    firstButtonIcon: Icons.cancel,
                                    secondButtonIcon: Icons.check,
                                    store: widget.editStore,
                                    onPressedSecond: () => widget.editStore.addPatient(
                                      patient: controller.updatePatient(),
                                    ),
                                    actionOnSuccess: () {
                                      widget.manageStore.getPatients();
                                      toogleOffAddNewPatient();
                                      controller.resetValues();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Dados Pessoais',
                        style: context.textStyles.textPoppinsMedium
                            .copyWith(fontSize: 16, color: context.colorsApp.success),
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
                                isValid: form.name.isValid,
                                validator: (_) => form.name.error?.exists,
                                errorText: form.name.displayError?.message,
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: AppFormField.height,
                                width: AppFormField.width,
                                child: ValueListenableBuilder(
                                  valueListenable: controller.selectedGender,
                                  builder: (context, gender, child) {
                                    return DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Sexo:',
                                        labelStyle: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: context.colorsApp.greyColor,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: context.colorsApp.greyColor,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: context.colorsApp.greyColor,
                                            width: 1,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: context.colorsApp.danger,
                                            width: 1,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: context.colorsApp.danger,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      value: gender.isNotEmpty ? gender : null,
                                      hint: const Text('Selecione uma opção'),
                                      isExpanded: true,
                                      items: gerenciarController.genderList
                                          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                                          .toList(),
                                      onChanged: (v) => v != null ? controller.setGender = v : null,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 150),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppFormField(
                                labelText: 'Idade:',
                                controller: controller.ageCt,
                                isValid: form.age.isValid,
                                validator: (_) => form.age.error?.exists,
                                errorText: form.age.displayError?.message,
                                inputFormatters: [AppFormatters.onlyNumber],
                              ),
                              const SizedBox(height: 10),
                              AppFormField(
                                labelText: 'Contato:',
                                controller: controller.phoneCt,
                                isValid: form.phone.isValid,
                                validator: (_) => form.phone.error?.exists,
                                errorText: form.phone.displayError?.message,
                                inputFormatters: [
                                  AppFormatters.phoneInputFormatter,
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Endereço',
                        style: context.textStyles.textPoppinsMedium
                            .copyWith(fontSize: 16, color: context.colorsApp.success),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppFormField(
                                labelText: 'Cidade:',
                                controller: controller.cityCt,
                                isValid: form.city.isValid,
                                validator: (_) => form.city.error?.exists,
                                errorText: form.city.displayError?.message,
                              ),
                              const SizedBox(height: 10),
                              AppFormField(
                                labelText: 'Bairro:',
                                controller: controller.neighCt,
                                isValid: form.neighborhood.isValid,
                                validator: (_) => form.neighborhood.error?.exists,
                                errorText: form.neighborhood.displayError?.message,
                              ),
                            ],
                          ),
                          const SizedBox(width: 180),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppFormField(
                                labelText: 'Rua:',
                                controller: controller.streetCt,
                                isValid: form.street.isValid,
                                validator: (_) => form.street.error?.exists,
                                errorText: form.street.displayError?.message,
                              ),
                              const SizedBox(height: 10),
                              AppFormField(
                                labelText: 'Número:',
                                controller: controller.numberCt,
                                isValid: form.number.isValid,
                                validator: (_) => form.number.error?.exists,
                                errorText: form.number.displayError?.message,
                                inputFormatters: [AppFormatters.onlyNumber],
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
                                    if (value.isEmpty) {
                                      return Text(
                                        'Nenhum registro',
                                        style: context.textStyles.textPoppinsMedium
                                            .copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                                      );
                                    }
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
                                              onSubmit: (v) {
                                                if (form.ilness.isValid) {
                                                  controller.onSubmitIlness(v);
                                                }
                                              },
                                              isValid: form.ilness.isValid,
                                              validator: (_) => form.ilness.error?.exists,
                                              errorText: form.ilness.displayError?.message,
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
                                  'A definir',
                                  style: context.textStyles.textPoppinsMedium
                                      .copyWith(fontSize: 14, color: context.colorsApp.greyColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  void toogleOffAddNewPatient() => gerenciarController.toogleAddNewPatient = false;
}
