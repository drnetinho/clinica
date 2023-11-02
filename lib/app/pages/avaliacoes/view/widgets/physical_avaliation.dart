import 'package:clisp/common/form/formatters/app_formatters.dart';
import 'package:flutter/material.dart';

import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';
import '../controller/new_avaliation_controller.dart';
import '../store/avaliations_store.dart';
import 'avaliation_label.dart';

class PhysicalAvaliation extends StatefulWidget {
  final GetAvaliationsStore store;
  final NewAvaliationController controller;
  const PhysicalAvaliation({
    Key? key,
    required this.store,
    required this.controller,
  }) : super(key: key);

  @override
  State<PhysicalAvaliation> createState() => _PhysicalAvaliationState();
}

class _PhysicalAvaliationState extends State<PhysicalAvaliation> {
  @override
  void initState() {
    super.initState();
    widget.controller.listenToForm();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller.form,
      builder: (context, form, _) {
        return Container(
          width: 450,
          decoration: BoxDecoration(
            border: Border.all(color: ColorsApp.instance.greyColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: Listenable.merge([
                    widget.controller.isNormal,
                  ]),
                  builder: (context, _) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        activeColor: ColorsApp.instance.primary,
                        value: true,
                        groupValue: widget.controller.isNormal.value,
                        onChanged: (v) => widget.controller.isNormal.value = true,
                      ),
                      const AvaliationLabel(title: 'Normal', fontSize: 14),
                      const SizedBox(width: 20),
                      Radio(
                        activeColor: ColorsApp.instance.primary,
                        value: false,
                        groupValue: widget.controller.isNormal.value,
                        onChanged: (v) => widget.controller.isNormal.value = false,
                      ),
                      const AvaliationLabel(title: 'Alterado', fontSize: 14),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _buildExameField(
                  label: "Pressão Arterial",
                  unit: "mmHg",
                  context: context,
                  controller: widget.controller.pressaoArterialCtrl,
                ),
                _buildExameField(
                  label: "Frequência Cardíaca",
                  unit: "bpm",
                  context: context,
                  controller: widget.controller.freqCardiacaCtrl,
                ),
                _buildExameField(
                  label: "Frequência Respiratória",
                  unit: "rpm",
                  context: context,
                  controller: widget.controller.freqRespiratoriaCtrl,
                ),
                Row(
                  children: [
                    _buildExameField(
                      label: "Peso",
                      unit: "kg",
                      context: context,
                      controller: widget.controller.pesoCtrl,
                    ),
                    const SizedBox(width: 20),
                    _buildExameField(
                      label: "Altura",
                      unit: "cm",
                      context: context,
                      controller: widget.controller.alturaCtrl,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExameField({
    required String label,
    required String unit,
    required BuildContext context,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: ColorsApp.instance.greyColor2),
          ),
          SizedBox(
            width: 80,
            child: TextFormField(
              style: TextStyle(
                color: ColorsApp.instance.primary,
              ),
              controller: controller,
              cursorColor: ColorsApp.instance.blackColor,
              decoration: const InputDecoration(
                hintText: "______",
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
              ),
              textAlign: TextAlign.center,
              strutStyle: const StrutStyle(height: 1.5),
              keyboardType: TextInputType.number,
              inputFormatters: [AppFormatters.onlyNumber],
              validator: (v) => v?.isEmpty ?? false ? '' : null,
            ),
          ),
          Text(
            unit,
            style: context.textStyles.textPoppinsMedium.copyWith(
              fontSize: 14,
              color: ColorsApp.instance.greyColor2,
            ),
          ),
        ],
      ),
    );
  }
}
