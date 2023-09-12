import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class SearchHeader extends StatefulWidget {
  final List<PatientModel> patients;
  final TextEditingController controller;
  final Function(List<PatientModel>?) findedPatients;
  final Function(bool) addPatient;

  const SearchHeader({
    super.key,
    required this.patients,
    required this.controller,
    required this.findedPatients,
    required this.addPatient,
  });

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: PhysicalModel(
                elevation: 10,
                color: context.colorsApp.backgroundCardColor,
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 30, color: ColorsApp.instance.success),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: widget.controller,
                            decoration: InputDecoration(
                              hintText: 'Pesquisar Paciente',
                              hintStyle: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
                              border: InputBorder.none,
                            ),
                            onChanged: (v) {
                              if (v.isNotEmpty) {
                                widget.findedPatients(
                                  widget.patients.where((p) => p.name.lower.contains(v.lower)).toList(),
                                );
                              } else {
                                widget.findedPatients(null);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            PhysicalModel(
              elevation: 10,
              color: context.colorsApp.backgroundCardColor,
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 50,
                width: 180,
                child: ElevatedButton(
                  onPressed: () => widget.addPatient(true),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 16, color: ColorsApp.instance.whiteColor),
                      const SizedBox(width: 8),
                      Text('Novo Paciente', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
