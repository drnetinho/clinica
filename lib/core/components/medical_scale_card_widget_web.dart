import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/doctors/domain/model/doctor.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/store/doctor_store.dart';
import 'package:netinhoappclinica/app/pages/scale/domain/model/doctor_scale.dart';
import 'package:netinhoappclinica/app/pages/scale/view/store/scale_store.dart';
import 'package:netinhoappclinica/core/components/store_builder.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import 'package:netinhoappclinica/di/get_it.dart';

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
    scaleStore.getScale();
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
            'Escala médica do dia',
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
                log(doctors.firstOrNull?.name ?? 'nenhum registro encontrado');
                return StoreBuilder<List<DoctorScale>>(
                    store: scaleStore,
                    validateDefaultStates: true,
                    builder: (context, scales, _) {
                      log(scales.firstOrNull?.doctorId ?? 'nenhum registro encontrado');
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
                                CircleAvatar(radius: 40 * unitHeight),
                                const SizedBox(width: 60),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dr. Francisco José',
                                      style: context.textStyles.textPoppinsSemiBold
                                          .copyWith(color: context.colorsApp.blackColor)
                                          .copyWith(fontSize: 26 * unitHeight),
                                    ),
                                    Text(
                                      'Clínico Geral',
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
                                        Icon(Icons.calendar_today,
                                            color: context.colorsApp.greyColor2, size: 40 * unitHeight),
                                        const SizedBox(width: 30),
                                        Text(
                                          'Quinta, 13 junho',
                                          style: context.textStyles.textPoppinsBold
                                              .copyWith(color: context.colorsApp.greyColor2, fontSize: 22 * unitHeight),
                                        ),
                                        const Spacer(),
                                        Icon(Icons.access_alarm,
                                            color: context.colorsApp.greyColor2, size: 40 * unitHeight),
                                        const SizedBox(width: 30),
                                        Text(
                                          '10:00' ' - ' '11:00',
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
                    });
              }),
        ],
      ),
    );
  }
}
