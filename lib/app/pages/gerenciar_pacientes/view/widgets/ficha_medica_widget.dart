import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart';
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
  late final ScrollController scrollController;
  late final ValueNotifier<bool> editMode;

  late final FichaMedicaController controller;
  late final GerenciarPacientesController gerenciarController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    controller = getIt<FichaMedicaController>();
    gerenciarController = getIt<GerenciarPacientesController>();
    editMode = ValueNotifier(false);
    controller.setupConfig(widget.patient);
    controller.setFormListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gerenciarController.patientSelected.addListener(() {
      if (editMode.value) {
        editMode.value = false;
      }
    });
  }

  @override
  void didUpdateWidget(covariant FichaMedicaWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.setupConfig(widget.patient);
  }

  Duration get animationDuration => kThemeAnimationDuration;
  TextStyle get defaultGreyStyle =>
      context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: context.colorsApp.greyColor);
  TextStyle get defaultBlackStyle => context.textStyles.textPoppinsMedium.copyWith(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.form,
        builder: (context, form, _) {
          return ValueListenableBuilder(
            valueListenable: editMode,
            builder: (context, isEditing, _) {
              final state = isEditing ? CrossFadeState.showSecond : CrossFadeState.showFirst;
              return Scrollbar(
                thumbVisibility: true,
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Ficha Médica', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30)),
                            const Spacer(),
                            Visibility(
                              visible: isEditing,
                              child: ExcluirButton(
                                discardMode: true,
                                onPressed: () {
                                  editMode.value = false;
                                  controller.resetValues();
                                  controller.setupConfig(widget.patient);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Visibility(
                              visible: !isEditing,
                              child: ExcluirButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AppDialog(
                                        title: 'Deseja Realmente excluir paciente?',
                                        firstButtonText: 'Cancelar',
                                        secondButtonText: 'Excluir',
                                        firstButtonIcon: Icons.close,
                                        secondButtonIcon: Icons.delete_outline,
                                        store: widget.editStore,
                                        onPressedSecond: () => widget.editStore.deletePatient(id: widget.patient.id),
                                        actionOnSuccess: () => widget.manageStore.getPatients(),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            EditarButton(
                              isEditing: editMode.value,
                              isLoading: widget.editStore.value.isLoading,
                              onPressed: () {
                                if (isEditing) {
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
                                        onPressedSecond: () => widget.editStore.updatePatient(
                                          patient: controller.updatePatient(),
                                        ),
                                        actionOnSuccess: () {
                                          widget.manageStore.getPatients();
                                          editMode.value = false;
                                        },
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
                          style: context.textStyles.textPoppinsSemiBold
                              .copyWith(fontSize: 22, color: context.colorsApp.success),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nome:', style: defaultBlackStyle),
                                Spacing.s.verticalGap,
                                AnimatedCrossFade(
                                  firstChild: Text(widget.patient.name, style: defaultGreyStyle),
                                  secondChild: AppFormField(
                                    controller: controller.nameCt,
                                    isValid: form.name.isValid,
                                    validator: (_) => form.name.error?.exists,
                                    errorText: form.name.displayError?.message,
                                  ),
                                  crossFadeState: state,
                                  duration: animationDuration,
                                ),
                                const SizedBox(height: 10),
                                Row(children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Idade:', style: defaultBlackStyle),
                                      Spacing.s.verticalGap,
                                      AnimatedCrossFade(
                                        firstChild: Text('${widget.patient.age} Anos', style: defaultGreyStyle),
                                        secondChild: AppFormField(
                                          maxWidth: 50,
                                          controller: controller.ageCt,
                                          isValid: form.age.isValid,
                                          validator: (_) => form.age.error?.exists,
                                          errorText: form.age.displayError?.message,
                                          inputFormatters: [AppFormatters.onlyNumber],
                                        ),
                                        crossFadeState: state,
                                        duration: animationDuration,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('CPF:', style: defaultBlackStyle),
                                      Spacing.s.verticalGap,
                                      //TODO ARTUR CPF AJUSTAR
                                      AnimatedCrossFade(
                                        firstChild: Text('000.000.000-00', style: defaultGreyStyle),
                                        secondChild: AppFormField(
                                          maxWidth: 140,
                                          controller: controller.ageCt,
                                          isValid: form.age.isValid,
                                          validator: (_) => form.age.error?.exists,
                                          errorText: form.age.displayError?.message,
                                          inputFormatters: [AppFormatters.onlyNumber],
                                        ),
                                        // secondChild: AppFormField(
                                        //   controller: controller.cpfCt,
                                        //   isValid: form.cpf.isValid,
                                        //   validator: (_) => form.cpf.error?.exists,
                                        //   errorText: form.cpf.displayError?.message,
                                        //   inputFormatters: [
                                        //     AppFormatters.cpfInputFormatter,
                                        //   ],
                                        // ),
                                        crossFadeState: state,
                                        duration: animationDuration,
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sexo:', style: defaultBlackStyle),
                                Spacing.s.verticalGap,
                                AnimatedCrossFade(
                                  firstChild: Text(widget.patient.gender, style: defaultGreyStyle),
                                  secondChild: SizedBox(
                                    height: AppFormField.height,
                                    width: AppFormField.width,
                                    child: ValueListenableBuilder(
                                      valueListenable: controller.selectedGender,
                                      builder: (context, gender, child) {
                                        return DropdownButtonFormField<String>(
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
                                  crossFadeState: state,
                                  duration: animationDuration,
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Contato:', style: defaultBlackStyle),
                                    Spacing.s.verticalGap,
                                    AnimatedCrossFade(
                                      firstChild: Text(widget.patient.phone, style: defaultGreyStyle),
                                      secondChild: AppFormField(
                                        controller: controller.phoneCt,
                                        isValid: form.phone.isValid,
                                        validator: (_) => form.phone.error?.exists,
                                        errorText: form.phone.displayError?.message,
                                        inputFormatters: [
                                          AppFormatters.phoneInputFormatter,
                                        ],
                                      ),
                                      crossFadeState: state,
                                      duration: animationDuration,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Endereço',
                          style: context.textStyles.textPoppinsSemiBold
                              .copyWith(fontSize: 22, color: context.colorsApp.success),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Cidade:', style: defaultBlackStyle),
                                Spacing.s.verticalGap,
                                AnimatedCrossFade(
                                  firstChild: Text(widget.patient.address?.city ?? '', style: defaultGreyStyle),
                                  secondChild: AppFormField(
                                    controller: controller.cityCt,
                                    isValid: form.city.isValid,
                                    validator: (_) => form.city.error?.exists,
                                    errorText: form.city.displayError?.message,
                                  ),
                                  crossFadeState: state,
                                  duration: animationDuration,
                                ),
                                const SizedBox(height: 10),
                                Text('Bairro:', style: defaultBlackStyle),
                                Spacing.s.verticalGap,
                                AnimatedCrossFade(
                                  firstChild: Text(widget.patient.address?.neighborhood ?? '', style: defaultGreyStyle),
                                  secondChild: AppFormField(
                                    controller: controller.neighCt,
                                    isValid: form.neighborhood.isValid,
                                    validator: (_) => form.neighborhood.error?.exists,
                                    errorText: form.neighborhood.displayError?.message,
                                  ),
                                  crossFadeState: state,
                                  duration: animationDuration,
                                ),
                              ],
                            ),
                            const SizedBox(width: 70),
                            Visibility(
                              visible: !isEditing,
                              child: const Spacer(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rua:', style: defaultBlackStyle),
                                Spacing.s.verticalGap,
                                AnimatedCrossFade(
                                  firstChild: Text(widget.patient.address?.street ?? '', style: defaultGreyStyle),
                                  secondChild: AppFormField(
                                    controller: controller.streetCt,
                                    isValid: form.street.isValid,
                                    validator: (_) => form.street.error?.exists,
                                    errorText: form.street.displayError?.message,
                                  ),
                                  crossFadeState: state,
                                  duration: animationDuration,
                                ),
                                const SizedBox(height: 10),
                                Text('Número:', style: defaultBlackStyle),
                                Spacing.s.verticalGap,
                                AnimatedCrossFade(
                                  firstChild: Text(widget.patient.address?.number ?? '', style: defaultGreyStyle),
                                  secondChild: AppFormField(
                                    controller: controller.numberCt,
                                    isValid: form.number.isValid,
                                    validator: (_) => form.number.error?.exists,
                                    errorText: form.number.displayError?.message,
                                    inputFormatters: [AppFormatters.onlyNumber],
                                  ),
                                  crossFadeState: state,
                                  duration: animationDuration,
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Doenças Pré-Existentes',
                                    style: context.textStyles.textPoppinsSemiBold
                                        .copyWith(fontSize: 22, color: context.colorsApp.success),
                                  ),
                                  const SizedBox(height: 10),
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
                                                '• $illness',
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            GestureDetector(
                                              onTap: () {
                                                controller.showIlnessField.value = true;
                                                scrollController.animateTo(
                                                  scrollController.position.maxScrollExtent,
                                                  duration: const Duration(milliseconds: 300),
                                                  curve: Curves.easeOut,
                                                );
                                              },
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Grupo Familiar',
                                  style: context.textStyles.textPoppinsSemiBold
                                      .copyWith(fontSize: 22, color: context.colorsApp.success),
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
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
