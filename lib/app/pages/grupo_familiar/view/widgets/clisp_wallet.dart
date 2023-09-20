import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';

import '../../../../../core/components/animated_resize.dart';

class ClispWallet extends StatelessWidget {
  final String groupName;
  final List<PatientModel> members;
  const ClispWallet({
    Key? key,
    required this.groupName,
    required this.members,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedResize(
      child: Dialog(
        child: Container(
          width: 500,
          height: 300,
          color: Colors.green,
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              children: List.generate(
                members.length,
                (index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(members[index].name),
                    Text(members[index].cpf),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
