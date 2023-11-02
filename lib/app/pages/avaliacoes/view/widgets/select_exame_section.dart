import 'package:flutter/material.dart';

import 'package:clisp/app/pages/avaliacoes/view/controller/new_avaliation_controller.dart';

import '../../../../../core/styles/colors_app.dart';
import 'avaliation_label.dart';

class SelectExameSection extends StatefulWidget {
  final NewAvaliationController controller;
  const SelectExameSection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SelectExameSection> createState() => _SelectExameSectionState();
}

class _SelectExameSectionState extends State<SelectExameSection> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller.exames,
      builder: (context, _) {
        return Column(
          children: List.generate(
            widget.controller.exames.value.length,
            (index) => Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check, color: context.colorsApp.primary, size: 14),
                      const SizedBox(width: 4),
                      AvaliationLabel(
                        title: widget.controller.exames.value[index],
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 150,
                    child: Divider(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
