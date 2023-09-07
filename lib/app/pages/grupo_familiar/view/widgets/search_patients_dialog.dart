import 'package:flutter/material.dart';

import 'package:netinhoappclinica/app/pages/grupo_familiar/view/widgets/search_group_patients.dart';

import '../controller/grupo_familiar_controller.dart';

class SearchPatientsDialog extends StatefulWidget {
  final GrupoFamiliarController controller;
  const SearchPatientsDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SearchPatientsDialog> createState() => _SearchPatientsDialogState();
}

class _SearchPatientsDialogState extends State<SearchPatientsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          SearchGroupPatients(
            controller: widget.controller.searchCt,
            patients: const [],
            findedPatients: (p) {
              if (p != null) {
                widget.controller.addSearchPatients = p;
              } else {
                widget.controller.resetSearch();
              }
            },
          ),
        ],
      ),
    );
  }
}
