import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clisp/app/pages/scale/view/store/scale_store.dart';
import 'package:clisp/core/styles/colors_app.dart';

import '../../../../../core/helps/padding.dart';
import '../../../../../core/helps/spacing.dart';
import '../../../doctors/domain/model/doctor.dart';
import '../../../doctors/view/widgets/new_doctor_dialog.dart';
import 'new_scale_dialog.dart';

class DoctorSelectorDialog extends StatefulWidget {
  final List<Doctor> doctors;
  final ScaleStore scaleStore;

  const DoctorSelectorDialog({
    Key? key,
    required this.doctors,
    required this.scaleStore,
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
      child: AnimatedBuilder(
          animation: selectedDoctor,
          builder: (context, _) {
            return Container(
              padding: Padd.sh(Spacing.x),
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .3,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: widget.doctors.map(
                        (doctor) {
                          return SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Radio(
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
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(doctor.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(doctor.name),
                                    Text(doctor.specialization),
                                  ],
                                )
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
                          icon: Icons.cancel,
                          color: context.colorsApp.whiteColor,
                          onPressed: context.pop,
                        ),
                        const SizedBox(width: 8),
                        actionButton(
                          text: "Confirmar",
                          context: context,
                          icon: Icons.check,
                          color: context.colorsApp.primary,
                          onPressed: selectedDoctor.value != null
                              ? () {
                                  context.pop();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return NewScaleDialog(
                                        doctor: selectedDoctor.value!,
                                        scaleStore: widget.scaleStore,
                                      );
                                    },
                                  );
                                }
                              : null,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
