import 'package:flutter/material.dart';

import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../clinica_icons_icons.dart';
import '../../../../../core/styles/colors_app.dart';

class GroupMemberTile extends StatelessWidget {
  final PatientModel member;
  final bool enableRemove;
  final VoidCallback? onRemoveMember;
  const GroupMemberTile({
    Key? key,
    required this.member,
    this.enableRemove = false,
    this.onRemoveMember,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, top: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(ClinicaIcons.profile, size: 30, color: ColorsApp.instance.success),
              const SizedBox(width: 8),
              Text(
                member.name,
                style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
              ),
              if (enableRemove) ...{
                const SizedBox(width: 20),
                IconButton(
                  onPressed: onRemoveMember,
                  icon: const Icon(Icons.close),
                )
              },
            ],
          ),
          Divider(color: ColorsApp.instance.greyColor),
        ],
      ),
    );
  }
}
