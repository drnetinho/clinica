import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';
import 'package:clisp/app/pages/doctors/view/store/doctor_store.dart';
import 'package:clisp/app/pages/scale/domain/model/doctor_scale.dart';
import 'package:clisp/app/pages/scale/view/store/scale_store.dart';
import 'package:clisp/core/components/state_widget.dart';
import 'package:clisp/core/components/store_builder.dart';
import 'package:clisp/core/helps/extension/date_extension.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:clisp/di/get_it.dart';

class MedicalScaleCardWidgetWeb extends StatefulWidget {
  const MedicalScaleCardWidgetWeb({
    super.key,
  });

  @override
  State<MedicalScaleCardWidgetWeb> createState() => _MedicalScaleCardWidgetWebState();
}

class _MedicalScaleCardWidgetWebState extends State<MedicalScaleCardWidgetWeb> {
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
    double unitHeight = MediaQuery.of(context).size.height * 0.001;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Próximas escalas médicas',
            style: context.textStyles.textPoppinsSemiBold.copyWith(
              color: context.colorsApp.blackColor,
              fontSize: 32 * unitHeight,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          StoreBuilder<List<Doctor>>(
            store: doctorStore,
            validateDefaultStates: false,
            builder: (context, doctors, _) {
              return StoreBuilder<List<DoctorScale>>(
                store: scaleStore,
                validateDefaultStates: true,
                builder: (context, scales, _) {
                  final DoctorScale? recentScale = scaleStore.getDoctorOfTheDay(scales);
                  final Doctor? recentScaleDoctor = doctorStore.getDoctorById(recentScale?.doctorId, doctors);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (recentScale == null || recentScaleDoctor == null) ...{
                        const SizedBox()
                      } else ...{
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mais próxima',
                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                color: context.colorsApp.primary,
                                fontSize: 18 * unitHeight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            scaleCard(
                              doctor: recentScaleDoctor,
                              scale: recentScale,
                              unitHeight: unitHeight,
                            ),
                          ],
                        ),
                      },
                      const SizedBox(height: 40),
                      if (scales.isEmpty)
                        const StateEmptyWidget(
                          message: 'Nenhuma escala encontrada',
                          icon: Icons.calendar_today,
                        ),
                      if (scales.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Todas',
                              style: context.textStyles.textPoppinsSemiBold.copyWith(
                                color: context.colorsApp.primary,
                                fontSize: 18 * unitHeight,
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
                                      unitHeight: unitHeight,
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
    required double unitHeight,
  }) {
    return SizedBox(
      height: 160 * unitHeight,
      width: MediaQuery.of(context).size.width,
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(10),
        color: context.colorsApp.dartMedium,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40 * unitHeight,
                backgroundImage: CachedNetworkImageProvider(doctor.image),
              ),
              const SizedBox(width: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doctor.name,
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(color: context.colorsApp.blackColor)
                        .copyWith(fontSize: 26 * unitHeight),
                  ),
                  Text(
                    doctor.specialization,
                    style: context.textStyles.textPoppinsRegular
                        .copyWith(color: context.colorsApp.blackColor)
                        .copyWith(fontSize: 22 * unitHeight),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.36,
                height: 50 * unitHeight,
                decoration: BoxDecoration(
                  color: context.colorsApp.dartWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today, color: context.colorsApp.primary, size: 40 * unitHeight),
                      const SizedBox(width: 30),
                      Text(
                        scale.date.toDateTime.formatted,
                        style: context.textStyles.textPoppinsBold
                            .copyWith(color: context.colorsApp.greyColor2, fontSize: 22 * unitHeight),
                      ),
                      const Spacer(),
                      Icon(Icons.access_alarm, color: context.colorsApp.primary, size: 40 * unitHeight),
                      const SizedBox(width: 30),
                      Text(
                        '${scale.start}' ' - ' '${scale.end}',
                        style: context.textStyles.textPoppinsBold
                            .copyWith(color: context.colorsApp.greyColor2, fontSize: 22 * unitHeight),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
