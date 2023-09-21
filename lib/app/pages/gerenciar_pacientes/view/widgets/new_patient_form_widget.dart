import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/editar_buttons.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../../common/form/formatters/app_formatters.dart';
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      width: MediaQuery.of(context).size.width * .4,
      child: PhysicalModel(
        elevation: 10,
        color: context.colorsApp.backgroundCardColor,
        borderRadius: BorderRadius.circular(20),
        child: ValueListenableBuilder<NewPatinetForm>(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            const SizedBox(height: 10),
                            Text(
                              'Dados Pessoais',
                              style: context.textStyles.textPoppinsSemiBold
                                  .copyWith(fontSize: 22, color: context.colorsApp.success),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppFormField(
                                      padding: EdgeInsets.zero,
                                      margin: EdgeInsets.zero,
                                      labelText: 'Nome:',
                                      controller: controller.nameCt,
                                      isValid: form.name.isValid,
                                      validator: (_) => form.name.error?.exists,
                                      errorText: form.name.displayError?.message,
                                    ),
                                    Row(
                                      children: [
                                        AppFormField(
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.zero,
                                          maxWidth: 50,
                                          labelText: 'Idade:',
                                          controller: controller.ageCt,
                                          isValid: form.age.isValid,
                                          validator: (_) => form.age.error?.exists,
                                          errorText: form.age.displayError?.message,
                                          inputFormatters: [AppFormatters.onlyNumber],
                                        ),
                                        const SizedBox(width: 10),
                                        //todo: ARTUR, COLOCAR O CPF AQUI
                                        AppFormField(
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.zero,
                                          maxWidth: 140,
                                          labelText: 'CPF',
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
                                const SizedBox(width: 140),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sexo:',
                                      style: context.textStyles.textPoppinsMedium
                                          .copyWith(fontSize: 14, color: context.colorsApp.blackColor),
                                    ),
                                    Spacing.s.verticalGap,
                                    SizedBox(
                                      height: 48,
                                      width: AppFormField.width,
                                      child: ValueListenableBuilder(
                                        valueListenable: controller.selectedGender,
                                        builder: (context, gender, child) {
                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelStyle: context.textStyles.textPoppinsMedium.copyWith(
                                                fontSize: 14,
                                                color: context.colorsApp.greyColor,
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
                                    const SizedBox(height: 44),
                                    AppFormField(
                                      padding: EdgeInsets.zero,
                                      margin: EdgeInsets.zero,
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
                            Text(
                              'Endereço',
                              style: context.textStyles.textPoppinsSemiBold
                                  .copyWith(fontSize: 22, color: context.colorsApp.success),
                            ),
                            const SizedBox(height: 10),
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
                                const SizedBox(width: 140),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Doenças Crônicas',
                                        style: context.textStyles.textPoppinsSemiBold
                                            .copyWith(fontSize: 22, color: context.colorsApp.success),
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
                                                const SizedBox(height: 20),
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
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Grupo Familiar',
                                        style: context.textStyles.textPoppinsSemiBold
                                            .copyWith(fontSize: 22, color: context.colorsApp.success),
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
                    ),
                  );
                },
              );
            }),
      ),
    );
  }

  void toogleOffAddNewPatient() => gerenciarController.toogleAddNewPatient = false;
}
