import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';

class DropButton extends StatefulWidget {
  const DropButton({Key? key}) : super(key: key);

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  final List<String> filtroGeral = ['Todos', 'Este mês', 'Este ano'];
  final List<String> meses1 = [
    'Janeiro',
    'Março',
    'Maio',
    'Julho',
    'Setembro',
    'Novembro',
  ];

  final List<String> meses2 = [
    'Fevereiro',
    'Abril',
    'Junho',
    'Agosto',
    'Outubro',
    'Dezembro',
  ];

  String selectedFilter = ''; // Opção selecionada inicialmente
  List<String> selectedMonths = [];

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
            border:
                Border.all(color: showFiltroGeral ? context.colorsApp.primary : context.colorsApp.greyColor, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showFiltroGeral = !showFiltroGeral;
                  showFiltroMes = false;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedFilter.isEmpty ? 'Filtrar por' : selectedFilter,
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
              border: Border.all(
                color: context.colorsApp.greyColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'Todos',
                        groupValue: selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            selectedFilter = value.toString();
                          });
                        },
                      ),
                      Text('Todos', style: TextStyle(color: context.colorsApp.greyColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Este mês',
                        groupValue: selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            selectedFilter = value.toString();
                          });
                        },
                      ),
                      Text('Este mês', style: TextStyle(color: context.colorsApp.greyColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Este ano',
                        groupValue: selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            selectedFilter = value.toString();
                          });
                        },
                      ),
                      Text('Este ano', style: TextStyle(color: context.colorsApp.greyColor)),
                    ],
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showFiltroMes = !showFiltroMes;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Filtrar por Mês',
                            style: TextStyle(
                              color: context.colorsApp.greyColor,
                            )),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Janeiro',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Janeiro', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Fevereiro',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Fevereiro', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Março',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Março', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Abril',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Abril', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Maio',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Maio', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Junho',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Junho', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Julho',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Julho', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Agosto',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Agosto', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Setembro',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Setembro', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Outubro',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Outubro', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Novembro',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Novembro', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Dezembro',
                            groupValue: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value.toString();
                              });
                            },
                          ),
                          Text('Dezembro', style: TextStyle(color: context.colorsApp.greyColor)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
