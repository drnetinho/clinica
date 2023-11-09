import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:clisp/core/components/state_widget.dart';
import 'package:clisp/core/components/store_builder.dart';
import 'package:clisp/core/helps/extension/date_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../app/pages/doctors/domain/model/doctor.dart';
import '../../app/pages/doctors/view/store/doctor_store.dart';
import '../../app/pages/scale/domain/model/doctor_scale.dart';
import '../../app/pages/scale/view/store/scale_store.dart';
import '../../di/get_it.dart';

class MedicalScaleCardWidgetMobile extends StatefulWidget {
  const MedicalScaleCardWidgetMobile({
    super.key,
  });

  @override
  State<MedicalScaleCardWidgetMobile> createState() => _MedicalScaleCardWidgetMobileState();
}

class _MedicalScaleCardWidgetMobileState extends State<MedicalScaleCardWidgetMobile> {
  late final ScaleStore scaleStore;
  late final DoctorStore doctorStore;

  @override
  void initState() {
    super.initState();
    scaleStore = getIt<ScaleStore>();
    doctorStore = getIt<DoctorStore>();
    doctorStore.getDoctors();
    scaleStore.getScales();
  }

  @override
  void dispose() {
    doctorStore.dispose();
    scaleStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Próximos atendimentos',
            style: context.textStyles.textPoppinsSemiBold.copyWith(
              color: context.colorsApp.blackColor,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          StoreBuilder<List<Doctor>>(
            store: doctorStore,
            validateDefaultStates: false,
            builder: (context, doctors, _) {
              return StoreBuilder<List<DoctorScale>>(
                store: scaleStore,
                validateDefaultStates: true,
                builder: (context, scales, _) {
                  final DoctorScale? recentScale = scaleStore.getDoctorOfTheDay(scales);
                  final Doctor? recentScaleDoctor = doctorStore.getDoctorFromList(
                    recentScale?.doctorId,
                    doctors,
                  );

                  return Column(
                    children: [
                      if (recentScale == null || recentScaleDoctor == null) ...{
                        const SizedBox(),
                      } else ...{
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mais próximo',
                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                color: context.colorsApp.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            scaleCard(
                              doctor: recentScaleDoctor,
                              scale: recentScale,
                            ),
                          ],
                        ),
                      },
                      const SizedBox(height: 20),
                      if (scales.isEmpty)
                        const StateEmptyWidget(
                          message: 'Nenhuma atendimento encontrado',
                          icon: Icons.calendar_today,
                        ),
                      if (scales.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Todos',
                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                color: context.colorsApp.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            ...scales.map(
                              (e) {
                                final other = doctors.firstWhereOrNull((element) => element.id == e.doctorId);
                                if (other == null) {
                                  return const SizedBox.shrink();
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: scaleCard(
                                      doctor: other,
                                      scale: e,
                                    ),
                                  );
                                }
                              },
                            ).toList()
                          ],
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget scaleCard({
    required DoctorScale scale,
    required Doctor doctor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        height: 130,
        width: MediaQuery.of(context).size.width,
        child: PhysicalModel(
          borderRadius: BorderRadius.circular(10),
          color: context.colorsApp.dartMedium,
          elevation: 5,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(doctor.image),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: context.textStyles.textPoppinsSemiBold
                                .copyWith(color: context.colorsApp.blackColor)
                                .copyWith(fontSize: 11),
                          ),
                          Text(
                            doctor.specialization,
                            style: context.textStyles.textPoppinsRegular
                                .copyWith(color: context.colorsApp.blackColor)
                                .copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: context.colorsApp.dartWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today, color: context.colorsApp.primary, size: 14),
                          const SizedBox(width: 15),
                          Text(
                            scale.dateTime.formatted,
                            style: context.textStyles.textPoppinsBold
                                .copyWith(color: context.colorsApp.greyColor2, fontSize: 8),
                          ),
                          const SizedBox(width: 40),
                          Icon(Icons.access_alarm, color: context.colorsApp.primary, size: 14),
                          const SizedBox(width: 15),
                          Text(
                            '${scale.start}' ' - ' '${scale.end}',
                            style: context.textStyles.textPoppinsBold
                                .copyWith(color: context.colorsApp.greyColor2, fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
