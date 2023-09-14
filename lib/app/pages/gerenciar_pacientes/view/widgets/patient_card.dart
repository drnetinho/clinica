import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class PatientCard extends StatefulWidget {
  final PatientModel patient;
  final bool isSelected;

  const PatientCard({
    Key? key,
    required this.patient,
    this.isSelected = false,
  }) : super(key: key);

  @override
  PatientCardState createState() => PatientCardState();
}

class PatientCardState extends State<PatientCard> {
  bool isHovered = false;

  Color getCollor() {
    if (widget.isSelected) {
      return ColorsApp.instance.greyColor.withOpacity(0.2);
    } else if (isHovered) {
      return ColorsApp.instance.greyColor.withOpacity(0.1);
    } else {
      return ColorsApp.instance.transparentColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: getCollor(),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 30, color: ColorsApp.instance.primary),
                    const SizedBox(width: 10),
                    Text(
                      widget.patient.name,
                      style: context.textStyles.textPoppinsMedium.copyWith(
                        fontSize: 18,
                        color: widget.isSelected ? ColorsApp.instance.primary : null,
                      ),
                    ),
                    if (kDebugMode) ...{
                      const SizedBox(width: 4),
                      Text(
                        widget.patient.id,
                        style: context.textStyles.textPoppinsMedium.copyWith(
                          fontSize: 14,
                          color: ColorsApp.instance.primary,
                        ),
                      ),
                    },
                    const Spacer(),
                    if (isHovered)
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: widget.isSelected ? ColorsApp.instance.greyColor : ColorsApp.instance.greyColor,
                      ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: !widget.isSelected,
            child: Divider(
              color: ColorsApp.instance.greyColor.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
