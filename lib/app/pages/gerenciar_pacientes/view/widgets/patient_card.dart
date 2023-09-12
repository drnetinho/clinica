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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2, top: 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.person, size: 30, color: ColorsApp.instance.primary),
                const SizedBox(width: 4),
                Text(
                  widget.patient.name,
                  style: context.textStyles.textPoppinsMedium.copyWith(
                    fontSize: 14,
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
              ],
            ),
            Divider(
              color: widget.isSelected ? ColorsApp.instance.greyColor : ColorsApp.instance.greyColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}


// class PatientCard extends StatelessWidget {
//   final PatientModel patient;
//   final bool isSelected;

//   const PatientCard({
//     Key? key,
//     required this.patient,
//     this.isSelected = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 2, top: 2),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Icon(Icons.person, size: 30, color: ColorsApp.instance.primary),
//               const SizedBox(width: 4),
//               Text(
//                 patient.name,
//                 style: context.textStyles.textPoppinsMedium.copyWith(
//                   fontSize: 14,
//                   color: isSelected ? ColorsApp.instance.primary : null,
//                 ),
//               ),
//               if (kDebugMode) ...{
//                 const SizedBox(width: 4),
//                 Text(
//                   patient.id,
//                   style: context.textStyles.textPoppinsMedium.copyWith(
//                     fontSize: 14,
//                     color: ColorsApp.instance.primary,
//                   ),
//                 ),
//               },
//               const Spacer(),

//               // ESSE ICON É PRA APARECER QUANDO O MAUSE ESTIVER EM CIMA DO CARD
//               Icon(
//                 Icons.arrow_forward_ios,
//                 size: 20,
//                 color: isSelected ? ColorsApp.instance.greyColor : ColorsApp.instance.greyColor,
//               ),
//             ],
//           ),
//           Divider(
//             color: isSelected ? ColorsApp.instance.greyColor : ColorsApp.instance.greyColor.withOpacity(0.5),
//           ),
//         ],
//       ),
//     );
//   }
// }
