// ignore_for_file: equal_elements_in_set

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/doctors/domain/model/doctor.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/store/doctor_store.dart';
import 'package:netinhoappclinica/app/pages/scale/domain/model/doctor_scale.dart';
import 'package:netinhoappclinica/app/pages/scale/view/store/scale_store.dart';
import 'package:netinhoappclinica/app/pages/scale/view/widgets/doctor_scale_card.dart';
import 'package:netinhoappclinica/app/pages/scale/view/widgets/doctor_selector_dialog.dart';
import 'package:netinhoappclinica/app/pages/scale/view/widgets/new_scale_buttom.dart';
import 'package:netinhoappclinica/app/pages/scale/view/widgets/new_scale_dialog.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/store_builder.dart';
import 'package:netinhoappclinica/core/helps/extension/date_extension.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../core/components/snackbar.dart';
import '../../../../di/get_it.dart';

class EditMedicalScale extends StatefulWidget {
  static const String routeName = '/edit_medical_scale';
  static const String subRoute = 'edit_medical_scale';
  const EditMedicalScale({super.key});

  @override
  State<EditMedicalScale> createState() => _EditMedicalScaleState();
}

class _EditMedicalScaleState extends State<EditMedicalScale> with SnackBarMixin, RouteAware {
  late final ScaleStore _scaleStore;
  late final EditScaleStore _editScaleStore;
  late final DoctorStore _doctorStore;

  late final ValueNotifier<Doctor?> selectedDoctor;

  @override
  void initState() {
    super.initState();
    selectedDoctor = ValueNotifier(null);
    _scaleStore = getIt<ScaleStore>()..getScales();
    _doctorStore = getIt<DoctorStore>()..getDoctors();
    _editScaleStore = getIt<EditScaleStore>();

    _editScaleStore.addListener(editScaleStoreListener);
  }

  @override
  void dispose() {
    _editScaleStore.removeListener(editScaleStoreListener);
    _scaleStore.dispose();
    _doctorStore.dispose();
    _editScaleStore.dispose();
    super.dispose();
  }

  void editScaleStoreListener() {
    if (_editScaleStore.value.isSuccess) {
      _scaleStore.getScales();
    } else if (_editScaleStore.value.isError) {
      showError(
        context: context,
        text: _editScaleStore.value.error.message,
      );
    }
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
            validateDefaultStates: false,
            builder: (context, doctors, _) {
              var groupedDoctorScales = scales.groupListsBy((e) => e.date.toDateTime.formatted);
              return Padding(
                padding: const EdgeInsets.only(left: 100, right: 50, top: 50, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Editar Escala Médica',
                          style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 36),
                        ),
                        IconButton(
                          onPressed: () => _scaleStore.getScales(),
                          icon: Icon(
                            Icons.refresh,
                            color: context.colorsApp.primary,
                          ),
                        ),
                      ],
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
                    if (scales.isEmpty) ...{
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timer_off_outlined,
                            size: 26,
                          ),
                          Text(
                            'Nenhuma escala médica cadastrada',
                            style: context.textStyles.textPoppinsSemiBold.copyWith(
                              color: context.colorsApp.greenColor2,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    } else ...{
                      Expanded(
                        child: ListView(
                          children: groupedDoctorScales.entries.map(
                            (scaleDateGroup) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      scaleDateGroup.key,
                                      style: context.textStyles.textPoppinsSemiBold.copyWith(
                                        color: context.colorsApp.greenColor2,
                                        fontSize: 28,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    if (scaleDateGroup.value.isNotEmpty) ...{
                                      Wrap(
                                        children: scaleDateGroup.value.map(
                                          (scale) {
                                            final doctor = doctors.firstWhereOrNull((e) => e.id == scale.doctorId);
                                            if (doctor != null) {
                                              return Padding(
                                                padding: const EdgeInsets.only(right: 20, bottom: 20),
                                                child: DoctorCardScale(
                                                  doctorScale: scale,
                                                  doctor: doctor,
                                                  onDeleteScale: () => _editScaleStore.deleteScale(scale: scale),
                                                  onEditScale: () => showDialog(
                                                    context: context,
                                                    builder: (context) => NewScaleDialog(
                                                      doctor: doctor,
                                                      scale: scale,
                                                      scaleStore: _scaleStore,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          },
                                        ).toList(),
                                      ),
                                    } else ...{
                                      const SizedBox.shrink(),
                                    },
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    },
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
