import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/doctors/domain/model/doctor.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/store/doctor_store.dart';
import 'package:netinhoappclinica/app/pages/scale/domain/model/doctor_scale.dart';
import 'package:netinhoappclinica/app/pages/scale/view/store/scale_store.dart';
import 'package:netinhoappclinica/app/pages/scale/view/widgets/doctor_scale_card.dart';
import 'package:netinhoappclinica/app/pages/scale/view/widgets/doctor_selector_dialog.dart';
import 'package:netinhoappclinica/app/pages/scale/view/widgets/new_scale_buttom.dart';
import 'package:netinhoappclinica/core/components/store_builder.dart';
import 'package:netinhoappclinica/core/helps/extension/date_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../di/get_it.dart';

class EditMedicalScale extends StatefulWidget {
  static const String routeName = 'edit_medical_scale';
  const EditMedicalScale({super.key});

  @override
  State<EditMedicalScale> createState() => _EditMedicalScaleState();
}

class _EditMedicalScaleState extends State<EditMedicalScale> {
  late final ScaleStore _scaleStore;
  late final DoctorStore _doctorStore;

  late final ValueNotifier<Doctor?> selectedDoctor;

  @override
  void initState() {
    super.initState();
    selectedDoctor = ValueNotifier(null);
    _scaleStore = getIt<ScaleStore>()..getScale();
    _doctorStore = getIt<DoctorStore>()..getDoctors();

    selectedDoctor.addListener(() {
      log(selectedDoctor.value?.name ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreBuilder<List<DoctorScale>>(
        store: _scaleStore,
        validateDefaultStates: true,
        builder: (context, scales, _) {
          return StoreBuilder<List<Doctor>>(
            store: _doctorStore,
            validateDefaultStates: true,
            builder: (context, doctors, _) {
              var groupedDoctorScales = scales.groupListsBy((e) => e.date.toDateTime.formatted);
              return Padding(
                padding: const EdgeInsets.only(left: 100, right: 50, top: 50, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Editar Escala Médica',
                      style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 36),
                    ),
                    const SizedBox(height: 20),
                    NewScaleButtom(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => DoctorSelectorDialog(
                          doctors: doctors,
                          scaleStore: _scaleStore,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: ListView(
                        children: groupedDoctorScales.entries.map(
                          (scaleDate) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    scaleDate.key,
                                    style: context.textStyles.textPoppinsSemiBold.copyWith(
                                      color: context.colorsApp.greenColor2,
                                      fontSize: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Wrap(
                                    children: scaleDate.value.map(
                                      (scale) {
                                        final doctor = doctors.firstWhereOrNull((e) => e.id == scale.doctorId);
                                        if (doctor != null) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 20, bottom: 20),
                                            child: DoctorCardScale(
                                              doctorScale: scale,
                                              doctor: doctor,
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    ).toList(),
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
