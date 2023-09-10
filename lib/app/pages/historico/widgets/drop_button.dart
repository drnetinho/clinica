import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/helps/extension/int_extension.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';

class DropButton extends StatefulWidget {
  const DropButton({Key? key}) : super(key: key);

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  String selectedFilter = '';

  bool showFiltroGeral = false;
  bool showFiltroMes = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 240,
          decoration: BoxDecoration(
            color: context.colorsApp.whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: showFiltroGeral ? context.colorsApp.primary : context.colorsApp.greyColor,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () => setState(() {
                showFiltroGeral = !showFiltroGeral;
                showFiltroMes = false;
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedFilter.isEmpty ? 'Filtrar' : selectedFilter,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Icon(
                    showFiltroGeral ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down_sharp,
                    color: context.colorsApp.greyColor,
                  )
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: showFiltroGeral,
          child: Container(
            height: 160,
            width: 240,
            decoration: BoxDecoration(
              color: context.colorsApp.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colorsApp.greyColor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRadio(value: 'Todos'),
                  buildRadio(value: 'Este mês'),
                  buildRadio(value: 'Este ano'),
                  const Divider(),
                  GestureDetector(
                    onTap: () => setState(() => showFiltroMes = !showFiltroMes),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Filtrar por Mês', style: TextStyle(color: context.colorsApp.greyColor)),
                        Icon(Icons.keyboard_arrow_down_sharp, color: context.colorsApp.greyColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: showFiltroMes,
          child: Container(
            height: 220,
            width: 240,
            decoration: BoxDecoration(
              color: context.colorsApp.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colorsApp.greyColor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Wrap(
                direction: Axis.vertical,
                children: List.generate(12, (index) => buildRadio(value: (index + 1).monthPerExtens())),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRadio({required String value}) => Row(
        children: [
          Radio(
            value: value,
            groupValue: selectedFilter,
            onChanged: (value) => setState(() => selectedFilter = value.toString()),
          ),
          Text(value, style: TextStyle(color: context.colorsApp.greyColor)),
        ],
      );
}
