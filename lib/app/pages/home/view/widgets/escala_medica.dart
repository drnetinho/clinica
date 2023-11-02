import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:clisp/common/state/app_state_extension.dart';
import 'package:clisp/core/components/snackbar.dart';
import 'package:clisp/core/helps/extension/date_extension.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/components/store_builder.dart';
import '../../../../../di/get_it.dart';
import '../../../doctors/domain/model/doctor.dart';
import '../../../doctors/view/store/doctor_store.dart';
import '../../../scale/domain/model/doctor_scale.dart';
import '../../../scale/view/store/scale_store.dart';

class EscalaMedica extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? background;
  final void Function()? onPressedEdit;
  const EscalaMedica({
    super.key,
    this.width,
    this.height,
    this.background,
    required this.onPressedEdit,
  });

  @override
  State<EscalaMedica> createState() => _EscalaMedicaState();
}

class _EscalaMedicaState extends State<EscalaMedica> with SnackBarMixin {
  late final ScaleStore scaleStore;
  late final DoctorStore doctorStore;

  @override
  void initState() {
    super.initState();
    scaleStore = getIt<ScaleStore>();
    doctorStore = getIt<DoctorStore>();
    doctorStore.getDoctors();
    scaleStore.getScales();
    scaleStore.addListener(scaleStoreListener);
  }

  @override
  void dispose() {
    doctorStore.dispose();
    scaleStore.dispose();
    scaleStore.removeListener(scaleStoreListener);
    super.dispose();
  }

  void scaleStoreListener() {
    if (scaleStore.value.isError) {
      showWarning(context: context, text: "Nenhuma escala recente foi encontrada. Revise as escalas cadastradas");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 400,
      height: widget.height ?? getheight(context),
      child: StoreBuilder<List<Doctor>>(
        store: doctorStore,
        validateDefaultStates: true,
        builder: (context, doctors, _) {
          return StoreBuilder<List<DoctorScale>>(
            store: scaleStore,
            validateDefaultStates: false,
            builder: (context, scales, _) {
              final DoctorScale? scale = scaleStore.getDoctorOfTheDay(scales);
              final Doctor? doctor = doctorStore.getDoctorById(scale?.doctorId, doctors);
              if (scale == null || doctor == null) {
                return const SizedBox();
              } else {
                return Column(
                  children: [
                    Text(
                      'PLACEHOLDER',
                      style: context.textStyles.textPoppinsSemiBold
                          .copyWith(fontSize: 28, color: context.colorsApp.transparentColor),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: PhysicalModel(
                        color: ColorsApp.instance.dartMedium,
                        borderRadius: BorderRadius.circular(20),
                        elevation: 5,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(doctor.image),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctor.name,
                                        style: context.textStyles.textPoppinsSemiBold
                                            .copyWith(color: context.colorsApp.blackColor)
                                            .copyWith(fontSize: 18),
                                      ),
                                      Text(
                                        doctor.specialization,
                                        style: context.textStyles.textPoppinsRegular
                                            .copyWith(color: context.colorsApp.greyColor2)
                                            .copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: widget.onPressedEdit,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.edit, size: 14),
                                        const SizedBox(width: 5),
                                        Text(
                                          'Editar',
                                          style: context.textStyles.textPoppinsSemiBold
                                              .copyWith(color: context.colorsApp.whiteColor)
                                              .copyWith(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: context.colorsApp.dartWhite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_today, color: context.colorsApp.primary, size: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                      scale.date.toDateTime.formatted,
                                      style: context.textStyles.textPoppinsSemiBold
                                          .copyWith(color: context.colorsApp.greyColor2, fontSize: 14),
                                    ),
                                    const SizedBox(width: 30),
                                    Icon(Icons.access_alarm, color: context.colorsApp.primary, size: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${scale.start}' ' - ' '${scale.end}',
                                      style: context.textStyles.textPoppinsSemiBold
                                          .copyWith(color: context.colorsApp.greyColor2, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }

  double getheight(BuildContext context) {
    // A altura nao pode ser menor que 250
    if (MediaQuery.of(context).size.height * 0.2 < 250) {
      return 250;
    } else {
      return MediaQuery.of(context).size.height * 0.22;
    }
  }
}
