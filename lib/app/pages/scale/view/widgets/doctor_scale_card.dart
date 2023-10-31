import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:clisp/core/helps/extension/date_extension.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';
import '../../../doctors/domain/model/doctor.dart';
import '../../domain/model/doctor_scale.dart';

class DoctorCardScale extends StatefulWidget {
  final DoctorScale doctorScale;
  final Doctor doctor;
  final VoidCallback? onDeleteScale;
  final VoidCallback? onEditScale;

  const DoctorCardScale({
    Key? key,
    required this.doctorScale,
    required this.doctor,
    this.onDeleteScale,
    this.onEditScale,
  }) : super(key: key);

  @override
  State<DoctorCardScale> createState() => _DoctorCardScaleState();
}

class _DoctorCardScaleState extends State<DoctorCardScale> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.doctorScale.isOlder ? .5 : 1,
      child: SizedBox(
        width: 440,
        height: 190,
        child: PhysicalModel(
          color: ColorsApp.instance.dartMedium,
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: widget.doctor.image.isNotEmpty,
                      replacement: const CircleAvatar(radius: 40),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: CachedNetworkImageProvider(widget.doctor.image),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctor.name,
                          style: context.textStyles.textPoppinsSemiBold
                              .copyWith(color: context.colorsApp.blackColor)
                              .copyWith(fontSize: 18),
                        ),
                        Text(
                          widget.doctor.specialization,
                          style: context.textStyles.textPoppinsRegular
                              .copyWith(color: context.colorsApp.greyColor2)
                              .copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    PopupMenuButton<int>(
                      icon: Icon(Icons.more_vert_outlined, color: context.colorsApp.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 0,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: context.colorsApp.danger,
                                ),
                                Text(
                                  'Deletar',
                                  style: TextStyle(
                                    color: context.colorsApp.danger,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  color: context.colorsApp.success,
                                ),
                                Text(
                                  'Editar',
                                  style: TextStyle(
                                    color: context.colorsApp.success,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ];
                      },
                      onSelected: (value) {
                        if (value == 0) {
                          widget.onDeleteScale?.call();
                        }
                        if (value == 1) {
                          widget.onEditScale?.call();
                        }
                      },
                    ),
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
                        widget.doctorScale.date.toDateTime.formatted,
                        style: context.textStyles.textPoppinsSemiBold
                            .copyWith(color: context.colorsApp.greyColor2, fontSize: 14),
                      ),
                      const SizedBox(width: 30),
                      Icon(Icons.access_alarm, color: context.colorsApp.primary, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        '${widget.doctorScale.start} - ${widget.doctorScale.end}',
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
    );
  }
}
