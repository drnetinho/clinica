import 'package:cached_network_image/cached_network_image.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clisp/app/pages/scale/view/store/scale_store.dart';
import 'package:clisp/core/styles/colors_app.dart';
import '../../../doctors/domain/model/doctor.dart';
import '../../../doctors/view/widgets/new_doctor_dialog.dart';
import 'new_scale_dialog.dart';

class DoctorSelectorDialog extends StatefulWidget {
  final List<Doctor> doctors;
  final ScaleStore? scaleStore;
  final Function(Doctor)? onSelectDoctor;

  const DoctorSelectorDialog({
    Key? key,
    required this.doctors,
    required this.scaleStore,
    this.onSelectDoctor,
  }) : super(key: key);

  @override
  State<DoctorSelectorDialog> createState() => _DoctorSelectorDialogState();
}

class _DoctorSelectorDialogState extends State<DoctorSelectorDialog> {
  late final ValueNotifier<Doctor?> selectedDoctor;

  @override
  void initState() {
    super.initState();
    selectedDoctor = ValueNotifier(null);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: AnimatedBuilder(
        animation: selectedDoctor,
        builder: (context, _) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.colorsApp.backgroundCardColor,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: widget.doctors.map(
                      (doctor) {
                        return SizedBox(
                          height: 90,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: context.colorsApp.primary,
                                    value: doctor.id,
                                    groupValue: selectedDoctor.value?.id,
                                    onChanged: (_) {
                                      if (selectedDoctor.value != doctor) {
                                        selectedDoctor.value = doctor;
                                      } else {
                                        selectedDoctor.value = null;
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: 58,
                                    width: 58,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(doctor.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(doctor.name,
                                          style: context.textStyles.textPoppinsSemiBold
                                              .copyWith(fontSize: 18, color: context.colorsApp.softBlack)),
                                      Text(doctor.specialization,
                                          style: context.textStyles.textPoppinsMedium
                                              .copyWith(fontSize: 16, color: context.colorsApp.greyColor2)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      actionButton(
                        text: "Cancelar",
                        context: context,
                        icon: Icons.close,
                        color: context.colorsApp.whiteColor,
                        onPressed: context.pop,
                      ),
                      const SizedBox(width: 12),
                      actionButton(
                        text: "Confirmar",
                        context: context,
                        icon: Icons.check,
                        color: context.colorsApp.primary,
                        iconColor: context.colorsApp.whiteColor,
                        textColor: context.colorsApp.whiteColor,
                        onPressed: selectedDoctor.value != null
                            ? () {
                                if (widget.onSelectDoctor != null) {
                                  widget.onSelectDoctor?.call(
                                    selectedDoctor.value!,
                                  );
                                  context.pop();
                                } else if (widget.scaleStore != null) {
                                  context.pop();
                                  showDialog(
                                    context: context,
                                    builder: (context) => NewScaleDialog(
                                      doctor: selectedDoctor.value!,
                                      scaleStore: widget.scaleStore!,
                                    ),
                                  );
                                }
                              }
                            : null,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
