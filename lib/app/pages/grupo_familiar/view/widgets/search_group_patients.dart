import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../gerenciar_pacientes/domain/model/patient_model.dart';

class SearchGroupPatients extends StatefulWidget {
  final List<PatientModel> patients;
  final TextEditingController controller;
  final Function(List<PatientModel>?)? findedPatients;
  final VoidCallback? onTap;

  const SearchGroupPatients({
    super.key,
    required this.patients,
    required this.controller,
     this.findedPatients,
    this.onTap,
  });

  @override
  State<SearchGroupPatients> createState() => _SearchGroupPatientsState();
}

class _SearchGroupPatientsState extends State<SearchGroupPatients> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width * .32,
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.onTap != null,
        onTap: widget.onTap,
        onChanged: (v) {
          if (widget.onTap == null) {
            if (v.isNotEmpty) {
              widget.findedPatients?.call(
                widget.patients.where((p) => p.name.lower.contains(v.lower)).toList(),
              );
            } else {
              widget.findedPatients?.call(null);
            }
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
}
