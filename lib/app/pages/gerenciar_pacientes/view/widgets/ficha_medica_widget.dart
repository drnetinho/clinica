import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/view/widgets/editar_buttons.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../../clinica_icons_icons.dart';
import '../../../../../common/form/formatters/app_formatters.dart';
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

class _FichaMedicaWidgetState extends State<FichaMedicaWidget> with SnackBarMixin {
  late final ScrollController scrollController;
  late final ValueNotifier<bool> editMode;

  late final FichaMedicaController controller;
  late final GerenciarPacientesController gerenciarController;

  @override
  void dispose() {
    editMode.dispose();
    scrollController.dispose();
    gerenciarController.searchCt.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    controller = getIt<FichaMedicaController>();
    gerenciarController = getIt<GerenciarPacientesController>();
    editMode = ValueNotifier(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.setFormListeners();
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * .78,
      width: MediaQuery.of(context).size.width * .4,
      child: PhysicalModel(
        elevation: 10,
        color: context.colorsApp.backgroundCardColor,
        borderRadius: BorderRadius.circular(20),
        child: ValueListenableBuilder(
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
                                Text('Ficha Médica',
                                    style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30)),
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
                                            onPressedSecond: () =>
                                                widget.editStore.deletePatient(id: widget.patient.id),
                                            actionOnSuccess: () {
                                              widget.manageStore.getPatients();
                                              gerenciarController.resetSearch();
                                              gerenciarController.resetPatient();
                                            },
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
                                      if (form.isValid) {
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
                                              onPressedSecond: () {
                                                widget.editStore.updatePatient(
                                                  patient: controller.updatePatient(),
                                                );
                                              },
                                              actionOnSuccess: () {
                                                widget.manageStore.getPatients();
                                                controller.resetValues();
                                                gerenciarController.resetSearch();
                                                gerenciarController.resetPatient();
                                                editMode.value = false;
                                              },
                                            );
                                          },
                                        );
                                      } else {
                                        showError(context: context, text: 'Preencha os campos corretamente');
                                      }
                                    } else {
                                      editMode.value = true;
                                      controller.setupConfig(widget.patient);
                                    }
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
                                        autovalidateMode: AutovalidateMode.always,
                                        controller: controller.nameCt,
                                        isValid: form.name.isValid,
                                        validator: (_) => form.name.error?.exists,
                                        errorText: form.name.error?.message,
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
                                              autovalidateMode: AutovalidateMode.always,
                                              maxWidth: 50,
                                              controller: controller.ageCt,
                                              isValid: form.age.isValid,
                                              validator: (_) => form.age.error?.exists,
                                              errorText: form.age.error?.exists,
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
                                          AnimatedCrossFade(
                                            firstChild: Text(widget.patient.cpf, style: defaultGreyStyle),
                                            secondChild: AppFormField(
                                              autovalidateMode: AutovalidateMode.always,
                                              maxWidth: 140,
                                              controller: controller.cpfCt,
                                              isValid: form.cpf.isValid,
                                              validator: (_) => form.cpf.error?.exists,
                                              errorText: form.cpf.error?.message,
                                              inputFormatters: [AppFormatters.cpfInputFormatter],
                                            ),
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
                                            autovalidateMode: AutovalidateMode.always,
                                            controller: controller.phoneCt,
                                            isValid: form.phone.isValid,
                                            validator: (_) => form.phone.error?.exists,
                                            errorText: form.phone.error?.message,
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
                            const SizedBox(height: 20),
                            Text(
                              'Endereço',
                              style: context.textStyles.textPoppinsSemiBold
                                  .copyWith(fontSize: 22, color: context.colorsApp.success),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        autovalidateMode: AutovalidateMode.always,
                                        controller: controller.cityCt,
                                        isValid: form.city.isValid,
                                        validator: (_) => form.city.error?.exists,
                                        errorText: form.city.error?.message,
                                      ),
                                      crossFadeState: state,
                                      duration: animationDuration,
                                    ),
                                    const SizedBox(height: 10),
                                    Text('Bairro:', style: defaultBlackStyle),
                                    Spacing.s.verticalGap,
                                    AnimatedCrossFade(
                                      firstChild:
                                          Text(widget.patient.address?.neighborhood ?? '', style: defaultGreyStyle),
                                      secondChild: AppFormField(
                                        autovalidateMode: AutovalidateMode.always,
                                        controller: controller.neighCt,
                                        isValid: form.neighborhood.isValid,
                                        validator: (_) => form.neighborhood.error?.exists,
                                        errorText: form.neighborhood.error?.message,
                                      ),
                                      crossFadeState: state,
                                      duration: animationDuration,
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * .3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Doenças Crônicas',
                                            style: context.textStyles.textPoppinsSemiBold
                                                .copyWith(fontSize: 22, color: context.colorsApp.success),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            height: 100,
                                            width: 200,
                                            child: ValueListenableBuilder(
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
                                                  // shrinkWrap: true,
                                                  itemBuilder: (context, index) {
                                                    final illness = value[index];

                                                    return Row(
                                                      children: [
                                                        Text(
                                                          '• $illness',
                                                          style: context.textStyles.textPoppinsMedium.copyWith(
                                                              fontSize: 14, color: context.colorsApp.greyColor),
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
                                          ),
                                          if (isEditing)
                                            ValueListenableBuilder(
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
                                                        autovalidateMode: AutovalidateMode.always,
                                                        controller: controller.ilnessCt,
                                                        onSubmit: (v) {
                                                          if (v.isNotEmpty) {
                                                            controller.onSubmitIlness(v);
                                                          }
                                                        },
                                                        isValid: form.ilness.isValid,
                                                        validator: (v) => v?.isNotEmpty == true ? null : '',
                                                        errorText: form.ilness.error?.message,
                                                      ),
                                                  ],
                                                );
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
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
                                        autovalidateMode: AutovalidateMode.always,
                                        controller: controller.streetCt,
                                        isValid: form.street.isValid,
                                        validator: (_) => form.street.error?.exists,
                                        errorText: form.street.error?.message,
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
                                        autovalidateMode: AutovalidateMode.always,
                                        controller: controller.numberCt,
                                        isValid: form.number.isValid,
                                        validator: (_) => form.number.error?.exists,
                                        errorText: form.number.error?.message,
                                        inputFormatters: [AppFormatters.onlyNumber],
                                      ),
                                      crossFadeState: state,
                                      duration: animationDuration,
                                    ),
                                    const SizedBox(height: 20),
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
                                        Row(
                                          children: [
                                            Icon(ClinicaIcons.family, color: context.colorsApp.primary),
                                            Spacing.s.horizotalGap,
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
                                const SizedBox(
                                  width: 20,
                                ),
                                const Spacer(),
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
}
