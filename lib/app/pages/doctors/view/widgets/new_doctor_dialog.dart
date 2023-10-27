// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netinhoappclinica/app/pages/doctors/domain/model/doctor.dart';
import 'package:netinhoappclinica/common/services/remote_config/remote_config_service.dart';
import 'package:netinhoappclinica/core/components/app_form_field.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../common/services/storage/firebase_storage.dart';
import '../../../../../core/helps/padding.dart';
import '../../../../../core/helps/spacing.dart';

class NewDoctorDialog extends StatefulWidget {
  final Doctor? doctor;
  final void Function(Doctor)? onConfirm;
  const NewDoctorDialog({
    Key? key,
    this.doctor,
    this.onConfirm,
  }) : super(key: key);

  @override
  State<NewDoctorDialog> createState() => _NewDoctorDialogState();
}

class _NewDoctorDialogState extends State<NewDoctorDialog> with SnackBarMixin {
  late final ValueNotifier<Doctor> doctor;
  late final ValueNotifier<String?> pickedImageuRL;
  late final TextEditingController nameController;
  late final TextEditingController specialtyController;

  @override
  void initState() {
    super.initState();
    doctor = ValueNotifier<Doctor>(widget.doctor ?? Doctor.empty());
    pickedImageuRL = ValueNotifier<String?>(null);

    nameController = TextEditingController(text: widget.doctor?.name);
    specialtyController = TextEditingController(text: widget.doctor?.specialization);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: AnimatedBuilder(
          animation: Listenable.merge([doctor, pickedImageuRL]),
          builder: (context, _) {
            return Container(
              padding: Padd.sh(Spacing.x),
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundColor: context.colorsApp.greenColor,
                            backgroundImage: NetworkImage(avatarUrl),
                          ),
                          CupertinoButton(
                            onPressed: () async {
                              final url = await StorageService.imgFromGallery();
                              if (url != null) {
                                pickedImageuRL.value = url;
                              } else {
                                showError(
                                  context: context,
                                  text: 'Error ao adicionar imagem',
                                );
                              }
                            },
                            child: Text(
                              "Adicionar imagem",
                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                fontSize: 12,
                                color: context.colorsApp.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          AnimatedBuilder(
                              animation: nameController,
                              builder: (context, _) {
                                return AppFormField(
                                  labelText: "Nome",
                                  controller: nameController,
                                  maxWidth: 400,
                                  onChanged: (p0) => doctor.value = doctor.value.copyWith(name: p0),
                                  isValid: nameController.text.isNotEmpty,
                                  helperText: "Digite pelo menos 6 caracteres",
                                  errorText: nameController.text.isEmpty ? null : "Campo inválido",
                                  validator: (p0) {
                                    if (p0 != null && (p0.isEmpty)) {
                                      return "";
                                    }
                                    return null;
                                  },
                                );
                              }),
                          AnimatedBuilder(
                              animation: specialtyController,
                              builder: (context, _) {
                                return AppFormField(
                                  labelText: "Especialidade",
                                  controller: specialtyController,
                                  maxWidth: 400,
                                  onChanged: (p0) => doctor.value = doctor.value.copyWith(specialization: p0),
                                  helperText: "Digite pelo menos 6 caracteres",
                                  isValid: specialtyController.text.hasMinimumLength,
                                  errorText:
                                      specialtyController.text.isEmpty || specialtyController.text.hasMinimumLength
                                          ? null
                                          : "Campo inválido",
                                  validator: (p0) {
                                    if (p0?.hasMinimumLength == false) {
                                      return "";
                                    }
                                    return null;
                                  },
                                );
                              }),
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
                          onPressed: () async {
                            if (pickedImageuRL.value?.isNotEmpty == true) {
                              await StorageService.deleteImage(pickedImageuRL.value ?? '');
                            }
                            context.pop();
                          },
                        ),
                        const SizedBox(width: 20),
                        AnimatedBuilder(
                            animation: Listenable.merge([nameController, specialtyController]),
                            builder: (context, _) {
                              return actionButton(
                                context: context,
                                text: "Confirmar",
                                icon: Icons.check,
                                color: context.colorsApp.primary,
                                onPressed:
                                    nameController.text.hasMinimumLength && specialtyController.text.hasMinimumLength
                                        ? () async {
                                            Doctor editedDoctor = doctor.value;

                                            if (pickedImageuRL.value?.isNotEmpty == true) {
                                              editedDoctor = editedDoctor.copyWith(
                                                image: pickedImageuRL.value!,
                                              );
                                            }
                                            widget.onConfirm?.call(editedDoctor);
                                            context.pop();
                                          }
                                        : null,
                              );
                            }),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  String get avatarUrl {
    return pickedImageuRL.value?.isNotEmpty == true
        ? pickedImageuRL.value!
        : doctor.value.image.isNotEmpty
            ? doctor.value.image
            : RMConfig.instance.emptyAvatar;
  }
}

Widget actionButton({
  VoidCallback? onPressed,
  required String text,
  required Color color,
  required IconData icon,
  required BuildContext context,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(icon, color: context.colorsApp.greyColor2, size: 16),
        const SizedBox(width: 6),
        Text(
          text,
          style: context.textStyles.textPoppinsSemiBold.copyWith(
            color: context.colorsApp.softBlack,
          ),
        ),
      ],
    ),
  );
}
