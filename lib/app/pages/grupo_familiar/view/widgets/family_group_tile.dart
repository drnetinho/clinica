import 'package:flutter/material.dart';

import 'package:clisp/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../clinica_icons_icons.dart';

class FamilyGroupTile extends StatefulWidget {
  final FamilyGroupModel group;
  final bool isSelected;

  const FamilyGroupTile({
    Key? key,
    required this.group,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<FamilyGroupTile> createState() => _FamilyGroupTileState();
}

class _FamilyGroupTileState extends State<FamilyGroupTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            selectedColor: context.colorsApp.primary,
            subtitle: Text(
              membersText(widget.group.members),
              style: context.textStyles.textPoppinsRegular.copyWith(fontSize: 15),
            ),
            title: Text(
              widget.group.name,
              style: context.textStyles.textPoppinsRegular.copyWith(fontSize: 20),
            ),
            selected: widget.isSelected,
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: context.colorsApp.whiteColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: context.colorsApp.primary, width: 2),
              ),
              child: Icon(ClinicaIcons.family, color: context.colorsApp.primary, size: 26),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .28,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Divider(thickness: 1, color: context.colorsApp.greyColor),
            ),
          ),
        ],
      ),
    );
  }

  String membersText(List<String> members) {
    if (members.isEmpty) {
      return 'Não possui membros';
    } else if (members.length == 1) {
      return '${widget.group.members.length} membro';
    } else {
      return '${widget.group.members.length} membros';
    }
  }
}
