import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:clisp/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../clinica_icons_icons.dart';

class FamilyGroupTile extends StatefulWidget {
  final FamilyGroupModel group;
  final bool isSelected;
  final bool isSelecting;

  const FamilyGroupTile({
    Key? key,
    required this.group,
    required this.isSelected,
    required this.isSelecting,
  }) : super(key: key);

  @override
  State<FamilyGroupTile> createState() => _FamilyGroupTileState();
}

class _FamilyGroupTileState extends State<FamilyGroupTile> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(ClinicaIcons.family, size: 30, color: ColorsApp.instance.primary),
                    const SizedBox(width: 10),
                    Text(
                      widget.group.name,
                      style: context.textStyles.textPoppinsMedium.copyWith(
                        fontSize: 18,
                        color: widget.isSelected ? ColorsApp.instance.primary : null,
                      ),
                    ),
                    if (kDebugMode) ...{
                      const SizedBox(width: 4),
                      Text(
                        widget.group.id,
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
                        color: widget.isSelecting ? ColorsApp.instance.greyColor : ColorsApp.instance.greyColor,
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
