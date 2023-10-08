import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_group_model.dart';
import 'package:netinhoappclinica/core/components/app_loader.dart';
import 'package:netinhoappclinica/core/components/store_builder.dart';

import '../../app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import '../../app/pages/grupo_familiar/view/store/get_group_members_store.dart';
import '../../di/get_it.dart';

class WalletDetails extends StatefulWidget {
  final FamilyGroupModel group;

  const WalletDetails({
    super.key,
    required this.group,
  });

  @override
  State<WalletDetails> createState() => _WalletDetailsState();
}

class _WalletDetailsState extends State<WalletDetails> {
  late final GetGroupMembersStore _getGroupMembersStore;

  @override
  void initState() {
    super.initState();
    _getGroupMembersStore = getIt<GetGroupMembersStore>()
      ..getGroupMembers(
        ids: widget.group.members,
      );
  }

  @override
  void dispose() {
    _getGroupMembersStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Group.png'),
        ),
      ),
      child: Center(
        child: StoreBuilder<List<PatientModel>>(
          store: _getGroupMembersStore,
          validateDefaultStates: true,
          loading: const AppLoader(primary: false),
          builder: (context, members, _) {
            return Wrap(
              children: members
                  .map(
                    (member) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(member.name),
                          Text(member.cpf),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
