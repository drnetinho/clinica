// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netinhoappclinica/app/pages/doctors/domain/model/doctor.dart';
import 'package:netinhoappclinica/app/pages/scale/domain/model/doctor_scale.dart';
import 'package:netinhoappclinica/common/form/formatters/app_formatters.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/app_form_field.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/helps/actual_date.dart';
import 'package:netinhoappclinica/core/helps/extension/date_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

import '../../../../../core/helps/padding.dart';
import '../../../../../core/helps/spacing.dart';
import '../../../doctors/view/widgets/new_doctor_dialog.dart';
import '../store/scale_store.dart';

class NewScaleDialog extends StatefulWidget {
  final DoctorScale? scale;
  final Doctor doctor;
  final ScaleStore scaleStore;

  const NewScaleDialog({
    Key? key,
    this.scale,
    required this.doctor,
    required this.scaleStore,
  }) : super(key: key);

  @override
  State<NewScaleDialog> createState() => _NewScaleDialogState();
}

class _NewScaleDialogState extends State<NewScaleDialog> with SnackBarMixin {
  late final ValueNotifier<DoctorScale> scale;
  late final TextEditingController dateCtrl;
  late final TextEditingController startCtrl;
  late final TextEditingController endCtrl;

  late final EditScaleStore _editScaleStore;

  @override
  void initState() {
    super.initState();
    scale = ValueNotifier<DoctorScale>(widget.scale ?? DoctorScale.empty());

    _editScaleStore = getIt<EditScaleStore>();

    _editScaleStore.addListener(editScaleListener);

    dateCtrl = TextEditingController();
    startCtrl = TextEditingController();
    endCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _editScaleStore.removeListener(editScaleListener);
    super.dispose();
  }

  void editScaleListener() {
    if (_editScaleStore.value.isSuccess) {
      context.pop();
      widget.scaleStore.getScale();
      showSuccess(
        context: context,
        text: 'Escala cadastrada com sucesso',
      );
    } else if (_editScaleStore.value.isError) {
      showError(
        context: context,
        text: _editScaleStore.value.error.message,
      );
    }
  }

  String get hourErrorMessage => "Informe um horário válido";
  String get dateErrorMessage => "Informe uma data";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge(
          [scale, dateCtrl, endCtrl, startCtrl],
        ),
        builder: (context, _) {
          return Container(
            padding: Padd.sh(Spacing.x),
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width * .3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: context.colorsApp.greyColor,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 75,
                                backgroundColor: context.colorsApp.greenColor,
                                backgroundImage: NetworkImage(widget.doctor.image),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                children: [
                                  Text(widget.doctor.name),
                                  Text(widget.doctor.specialization),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AnimatedBuilder(
                              animation: dateCtrl,
                              builder: (context, _) {
                                return AppFormField(
                                  controller: dateCtrl,
                                  hint: KCurrentDate.formatted,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  prefixIcon: Icon(
                                    Icons.calendar_month,
                                    color: context.colorsApp.success,
                                  ),
                                  readOnly: true,
                                  onTap: () => showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(const Duration(days: 365)),
                                    builder: (context, child) => WrapTheme(
                                      date: true,
                                      child: child!,
                                    ),
                                  ).then((value) {
                                    if (value != null) {
                                      dateCtrl.text = value.formatted;
                                    }
                                  }),
                                  maxWidth: 200,
                                  onChanged: updateScaleDate,
                                  onSubmit: updateScaleDate,
                                  isValid: dateCtrl.text.isNotEmpty,
                                  errorText: dateCtrl.text.isNotEmpty ? null : dateErrorMessage,
                                  inputFormatters: [AppFormatters.date],
                                  validator: validateField,
                                );
                              },
                            ),
                            AnimatedBuilder(
                              animation: startCtrl,
                              builder: (context, _) {
                                return AppFormField(
                                  hint: "00:00",
                                  controller: startCtrl,
                                  maxWidth: 120,
                                  prefixIcon: Icon(
                                    Icons.timer,
                                    color: context.colorsApp.success,
                                  ),
                                  readOnly: true,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialEntryMode: TimePickerEntryMode.dial,
                                      initialTime: const TimeOfDay(hour: 0, minute: 0),
                                      builder: (context, child) => WrapTheme(child: child!),
                                    ).then((value) {
                                      if (value != null) {
                                        startCtrl.text = value.format(context);
                                      }
                                    });
                                  },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: updateScaleStart,
                                  onSubmit: updateScaleStart,
                                  isValid: startCtrl.text.isNotEmpty,
                                  inputFormatters: [AppFormatters.hourFormatter],
                                  errorText: startCtrl.text.isNotEmpty ? null : hourErrorMessage,
                                  validator: validateField,
                                );
                              },
                            ),
                            AnimatedBuilder(
                              animation: endCtrl,
                              builder: (context, _) {
                                return AppFormField(
                                  hint: "00:00",
                                  maxWidth: 120,
                                  controller: endCtrl,
                                  prefixIcon: Icon(
                                    Icons.timer,
                                    color: context.colorsApp.success,
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: updateScaleEnd,
                                  onSubmit: updateScaleEnd,
                                  isValid: endCtrl.text.isNotEmpty,
                                  inputFormatters: [AppFormatters.hourFormatter],
                                  errorText: endCtrl.text.isNotEmpty ? null : hourErrorMessage,
                                  readOnly: true,
                                  onTap: () => showTimePicker(
                                    context: context,
                                    initialEntryMode: TimePickerEntryMode.dial,
                                    initialTime: const TimeOfDay(hour: 0, minute: 0),
                                    builder: (context, child) => WrapTheme(child: child!),
                                  ).then((value) {
                                    if (value != null) {
                                      endCtrl.text = value.format(context);
                                    }
                                  }),
                                  validator: validateField,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      actionButton(
                        text: "Cancelar",
                        context: context,
                        icon: Icons.cancel,
                        color: context.colorsApp.whiteColor,
                        onPressed: context.pop,
                      ),
                      const SizedBox(width: 20),
                      AnimatedBuilder(
                        animation: Listenable.merge([dateCtrl, startCtrl]),
                        builder: (context, _) {
                          return actionButton(
                            text: "Confirmar",
                            context: context,
                            icon: Icons.check,
                            color: context.colorsApp.primary,
                            onPressed: isValidForm
                                ? () => _editScaleStore.createScale(
                                      scale: scale.value.copyWith(
                                        doctorId: widget.doctor.id,
                                        date: dateCtrl.text.toDateTimeFormatted.toIso8601String(),
                                        start: startCtrl.text,
                                        end: endCtrl.text,
                                      ),
                                    )
                                : null,
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool get isValidForm {
    bool dateIsValid = validateField(dateCtrl.text) == null;
    bool startIsValid = validateField(startCtrl.text) == null;
    bool endIsValid = validateField(endCtrl.text) == null;
    return dateIsValid && startIsValid && endIsValid;
  }

  String? validateField(String? p0) => (p0 != null && (p0.isEmpty)) ? "" : null;

  void updateScaleDate(p0) => scale.value = scale.value.copyWith(date: p0);
  void updateScaleStart(p0) => scale.value = scale.value.copyWith(start: p0);
  void updateScaleEnd(p0) => scale.value = scale.value.copyWith(end: p0);
}

class WrapTheme extends StatelessWidget {
  final Widget child;
  final bool date;
  const WrapTheme({Key? key, required this.child, this.date = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: context.colorsApp.primary,
            onPrimary: date ? context.colorsApp.whiteColor : context.colorsApp.primary,
            onSurface: context.colorsApp.blackColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
          ),
        ),
        child: child,
      ),
    );
  }
}
