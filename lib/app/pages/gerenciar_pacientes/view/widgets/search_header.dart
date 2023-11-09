import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/colors_app.dart';

class SearchHeader extends StatefulWidget {
  final List<PatientModel> patients;
  final TextEditingController controller;
  final Function(List<PatientModel>?) findedPatients;
  final Function(bool)? addPatient;
  final bool isAddPatient;

  const SearchHeader({
    Key? key,
    required this.patients,
    required this.controller,
    required this.findedPatients,
    this.addPatient,
    this.isAddPatient = true,
  }) : super(key: key);

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
                elevation: 1,
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
                        Icon(Icons.search, size: 30, color: ColorsApp.instance.greyColor2),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: widget.controller,
                            cursorColor: context.colorsApp.primary,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              isDense: true,
                              hintText: 'Pesquisar Paciente',
                              hintStyle: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
                            ),
                            style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14),
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
                        const SizedBox(width: 10),
                        CupertinoButton(
                          onPressed: () {
                            widget.controller.clear();
                            widget.findedPatients(null);
                          },
                          padding: EdgeInsets.zero,
                          child: Icon(Icons.clear, size: 30, color: ColorsApp.instance.greyColor2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Visibility(
              visible: widget.isAddPatient,
              child: PhysicalModel(
                elevation: 1,
                color: context.colorsApp.backgroundCardColor,
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () => widget.addPatient?.call(true),
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
            ),
          ],
        ),
      ],
    );
  }
}
