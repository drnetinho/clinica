import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/app/pages/relatorios/view/widgets/group_tile.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class GroupsCard extends StatefulWidget {
  final List<FamilyGroupModel> groups;
  final String filter;

  const GroupsCard({
    Key? key,
    required this.groups,
    required this.filter,
  }) : super(key: key);

  @override
  State<GroupsCard> createState() => _GroupsCardState();
}

class _GroupsCardState extends State<GroupsCard> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      width: MediaQuery.of(context).size.width * .28,
      child: Card(
        color: context.colorsApp.backgroundCardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 1,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Nome do Grupo',
                  style:
                      context.textStyles.textPoppinsRegular.copyWith(fontSize: 14, color: context.colorsApp.greyColor2),
                ),
                Text(
                  'Mensalidade',
                  style:
                      context.textStyles.textPoppinsRegular.copyWith(fontSize: 14, color: context.colorsApp.greyColor2),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(thickness: 2, color: context.colorsApp.greyColor),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .72,
              width: MediaQuery.of(context).size.width * .28,
             
              child: SingleChildScrollView(
                child: Column(
                  children: widget.groups
                      .map(
                        (e) => GroupTile(
                          group: e,
                          filter: widget.filter,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
