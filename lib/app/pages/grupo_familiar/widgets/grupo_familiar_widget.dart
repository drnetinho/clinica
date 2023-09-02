import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../gerenciar/widgets/editar_buttons.dart';
import '../../gerenciar/widgets/excluir_buttons.dart';

class GrupoFamiliarWidget extends StatelessWidget {
  const GrupoFamiliarWidget({
    super.key,
    required this.grupoFamiliar,
  });

  final List<String> grupoFamiliar;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorsApp.backgroundCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Família Souza', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 22)),
                const Spacer(),
                ExcluirButton(onPressed: () {}),
                const SizedBox(width: 10),
                EditarButton(onPressed: () {})
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: grupoFamiliar.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 2, top: 2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person, size: 30, color: ColorsApp.instance.primaryColorGrean),
                          const SizedBox(width: 1),
                          Text(grupoFamiliar[index], style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                        ],
                      ),
                      Divider(color: ColorsApp.instance.greyColor),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'Histórico de Pagamentos',
              style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 24, color: ColorsApp.instance.primaryColorGrean),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Valor', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: ColorsApp.instance.greyColor2)),
                    Text('R\$ 50,00', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vencimento',
                        style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: ColorsApp.instance.greyColor2)),
                    Text('10/10/2021', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status', style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 16, color: ColorsApp.instance.greyColor2)),
                  ],
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.search, size: 20, color: ColorsApp.instance.primaryColorGrean),
                const SizedBox(width: 6),
                Text('Visualizar histórico completo',
                    style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: ColorsApp.instance.primaryColorGrean)),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsApp.instance.primaryColorGrean, width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 20, color: ColorsApp.instance.primaryColorGrean),
                      const SizedBox(width: 6),
                      Text('Ver Carteirinha',
                          style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: ColorsApp.instance.primaryColorGrean)),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
