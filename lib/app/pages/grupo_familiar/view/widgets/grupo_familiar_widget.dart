import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/group_member_tile.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/grupo_familiar_footer.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/historic_button.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/wallet_button.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/components/store_builder.dart';
import '../../../gerenciar_pacientes/view/widgets/editar_buttons.dart';
import '../../../gerenciar_pacientes/view/widgets/excluir_buttons.dart';
import '../store/group_members_store.dart';

class GrupoFamiliarWidget extends StatefulWidget {
  final FamilyGroupModel group;
  final GrupMembersStore store;
  const GrupoFamiliarWidget({
    super.key,
    required this.group,
    required this.store,
  });

  @override
  State<GrupoFamiliarWidget> createState() => _GrupoFamiliarWidgetState();
}

class _GrupoFamiliarWidgetState extends State<GrupoFamiliarWidget> {
  @override
  void initState() {
    super.initState();
    widget.store.getGroupMembers(ids: widget.group.members);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorsApp.backgroundCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Família Souza', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 22)),
                const Spacer(),
                ExcluirButton(onPressed: () {}),
                const SizedBox(width: 10),
                EditarButton(
                  isEditing: false,
                  onPressed: () {},
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StoreBuilder<List<PatientModel>>(
                  store: widget.store,
                  builder: (context, members, child) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        return GroupMemberTile(member: members[index]);
                      },
                    );
                  }),
            ),
            Text(
              'Histórico de Pagamentos',
              style: context.textStyles.textPoppinsMedium.copyWith(
                fontSize: 24,
                color: ColorsApp.instance.success,
              ),
            ),
            const SizedBox(height: 20),
            GrupoFamiliarFooter(group: widget.group),
            const SizedBox(height: 20),
            HistoricButton(
              onTap: () {},
            ),
            const SizedBox(height: 20),
             Center(
              child: WalletButton(
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
