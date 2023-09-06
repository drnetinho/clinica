import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class SearchHeader extends StatefulWidget {
  final List<PatientModel> patients;
  final TextEditingController controller;
  final Function(List<PatientModel>?) findedPatients;

  const SearchHeader({
    super.key,
    required this.patients,
    required this.controller,
    required this.findedPatients,
  });

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Gerenciar Pacientes',
          style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 30),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 60,
                child: Card(
                  color: context.colorsApp.backgroundCardColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 16, color: ColorsApp.instance.whiteColor),
                      const SizedBox(width: 10),
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
