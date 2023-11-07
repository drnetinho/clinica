import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class GerarCarneWidget extends StatelessWidget {
  const GerarCarneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pdfViewer(context);
      },
      child: Row(
        children: [
          Icon(
            Icons.menu_book_sharp,
            size: 20,
            color: ColorsApp.instance.success,
          ),
          const SizedBox(width: 6),
          Text(
            'Gerar carnê',
            style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 14, color: ColorsApp.instance.success),
          ),
        ],
      ),
    );
  }
}

final list = List.generate(
  4,
  (index) => Printter(
    members: ['Membro 1', 'Membro 2', 'Membro 3'],
    cpf: ['CPF 1', 'CPF 2', 'CPF 3'],
    grupo: 'Grupo Thiago',
  ),
);

Future pdfViewer(
  BuildContext context,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        for (var i = 0; i < list.length; i++)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(list[i].grupo),
              for (var j = 0; j < list[i].members.length; j++)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(list[i].members[j]),
                    pw.Text(list[i].cpf[j]),
                  ],
                ),
              pw.Divider(),
            ],
          ),
      ],
    ),
  );

  // await file.writeAsBytes(await pdf.save());
  await pdf.save();
  await Printing.sharePdf(bytes: await pdf.save(), filename: 'my-document.pdf');
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  return pdf.save();
}

class Printter {
  final List<String> members;
  final List<String> cpf;
  final String grupo;

  Printter({
    required this.members,
    required this.cpf,
    required this.grupo,
  });
}
