import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../gerenciar_pacientes/domain/model/patient_model.dart';
import '../../domain/model/family_group_model.dart';

class SearchGroupPatients extends StatefulWidget {
  final List<PatientModel> patients;
  final List<FamilyGroupModel> groups;

  final TextEditingController? controller;
  final Function(List<PatientModel>?)? findedPatients;
  final Function(List<FamilyGroupModel>?)? findedGroups;
  final VoidCallback? onTap;
  final bool autoFocus;
  final bool searchByGroup;
  final double width;

  const SearchGroupPatients({
    super.key,
    required this.patients,
    required this.groups,
    required this.width,
    this.findedGroups,
    this.controller,
    this.findedPatients,
    this.onTap,
    this.autoFocus = false,
    required this.searchByGroup,
  });

  @override
  State<SearchGroupPatients> createState() => _SearchGroupPatientsState();
}

class _SearchGroupPatientsState extends State<SearchGroupPatients> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.onTap != null,
        onTap: widget.onTap,
        autofocus: widget.autoFocus,
        onChanged: (v) {
          if (v.isNotEmpty) {
            if (widget.searchByGroup) {
              widget.findedGroups?.call(
                widget.groups.where((g) => containsCase(g.name, v)).toList(),
              );
            } else {
              widget.findedPatients?.call(
                widget.patients.where((p) => containsCase(p.name, v)).toList(),
              );
            }
          } else {
            widget.findedPatients?.call(null);
            widget.findedGroups?.call(null);
          }
        },
        decoration: InputDecoration(
          hintText: 'Buscar Pacientes',
          hintStyle: context.textStyles.textPoppinsRegular.copyWith(fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          icon: Icon(Icons.search, color: context.colorsApp.greyColor2),
          filled: true,
          fillColor: context.colorsApp.backgroundCardColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }

  bool containsCase(String a, String b) => a.lower.contains(b.lower);
}
