import 'package:flutter/material.dart';

import 'package:clisp/core/helps/extension/int_extension.dart';
import 'package:clisp/core/helps/filter.dart';
import 'package:clisp/core/styles/colors_app.dart';

class DropFilter extends StatefulWidget {
  final Function(String) selectedValue;
  final String? currentFilter;

  const DropFilter({
    Key? key,
    required this.selectedValue,
    this.currentFilter,
  }) : super(key: key);

  @override
  State<DropFilter> createState() => _DropFilterState();
}

class _DropFilterState extends State<DropFilter> {
  late final ValueNotifier<String> selectedFilter;

  late bool showFiltroGeral;
  late bool showFiltroMes;

  @override
  void dispose() {
    selectedFilter.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setup(false);
    selectedFilter = ValueNotifier(widget.currentFilter ?? FilterStrings.todos);

    selectedFilter.addListener(() {
      widget.selectedValue.call(selectedFilter.value);
    });
  }

  void setup(bool value) {
    showFiltroGeral = value;
    showFiltroMes = value;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: selectedFilter,
        builder: (context, _) {
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
                          selectedFilter.value.isEmpty ? 'Filtrar' : selectedFilter.value,
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
                        buildRadio(value: FilterStrings.todos),
                        buildRadio(value: FilterStrings.esteMes),
                        buildRadio(value: FilterStrings.esteAno),
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
        });
  }

  Widget buildRadio({required String value}) => Row(
        children: [
          Radio(
            activeColor: ColorsApp.instance.primary,
            value: value,
            groupValue: selectedFilter.value,
            onChanged: (value) => selectedFilter.value = value.toString(),
          ),
          Text(value, style: TextStyle(color: context.colorsApp.greyColor)),
        ],
      );
}
