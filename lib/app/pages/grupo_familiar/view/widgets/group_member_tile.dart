import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class GroupMemberTile extends StatelessWidget {
  final PatientModel member;
  const GroupMemberTile({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, top: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.person, size: 30, color: ColorsApp.instance.success),
              const SizedBox(width: 1),
              Text(
                member.name,
                style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
              ),
            ],
          ),
          Divider(color: ColorsApp.instance.greyColor),
        ],
      ),
    );
  }
}
