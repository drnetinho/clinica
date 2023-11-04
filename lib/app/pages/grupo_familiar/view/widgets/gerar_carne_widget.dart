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

// final list = List.generate(
//   4,
//   (index) => Printter(
//     nome: 'Nome $index',
//     cpf: 'CPF $index',
//     grupo: 'Grupo $index',
//     image: 'https://www.nfet.net/nfet.jpg',
//   ),
// );

// Future pdfViewer(
//   BuildContext context,
// ) async {
//   // Add your function code here!
//   final pdf = pw.Document();

//   for (var i in list) {
//     final netImage = await networkImage(i.image);
//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         build: (context) => [
//           pw.Text(i.nome),
//           pw.Text(i.cpf),
//           pw.Text(i.grupo),
//           pw.Image(netImage),
//           pw.Divider(),
//         ],
//       ),
//     );
//   }

//   // await file.writeAsBytes(await pdf.save());
//   await pdf.save();
//   await Printing.sharePdf(bytes: await pdf.save(), filename: 'my-document.pdf');
//   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
//   return pdf.save();
// }

// class Printter {
//   final String nome;
//   final String cpf;
//   final String grupo;
//   final String image;
//   Printter({
//     required this.nome,
//     required this.cpf,
//     required this.grupo,
//     required this.image,
//   });
// }

final list = List.generate(
  12,
  (index) => Printter(
    parcela: 1 + index,
    vencimento: '01/01/2021',
    valor: 100,
    nomeGrupo: 'Grupo Thiago',
    nomeresponsavel: 'Thiago Fernandes',
    cpf: '08311091498',
    image: 'https://www.nfet.net/nfet.jpg',
  ),
);

Future pdfViewer(
  BuildContext context,
) async {
  // Add your function code here!
  final pdf = pw.Document();

  for (var i in list) {
    final netImage = await networkImage(i.image);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        margin: const pw.EdgeInsets.all(16),
        build: (context) => [
          pw.Divider(),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('Parcela: ${i.parcela}/12'),
                  pw.SizedBox(height: 10),
                  pw.Container(height: 1, width: 150, color: PdfColors.black),
                  pw.SizedBox(height: 10),
                  pw.Text('Vencimento: ${i.vencimento}'),
                  pw.SizedBox(height: 10),
                  pw.Container(height: 1, width: 150, color: PdfColors.black),
                  pw.SizedBox(height: 10),
                  pw.Text('Valor: ${i.valor}'),
                  pw.SizedBox(height: 10),
                  pw.Container(height: 1, width: 150, color: PdfColors.black),
                ],
              ),
              pw.Container(height: 100, width: 1, color: PdfColors.black),
              pw.SizedBox(width: 4),
              pw.Container(height: 100, width: 1, color: PdfColors.black),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text('Parcela: ${i.parcela}/12'),
                        pw.SizedBox(height: 10),
                        pw.Container(height: 1, width: 130, color: PdfColors.black),
                        pw.SizedBox(height: 10),
                        pw.Text('Vencimento: ${i.vencimento}'),
                        pw.SizedBox(height: 10),
                        pw.Container(height: 1, width: 130, color: PdfColors.black),
                        pw.SizedBox(height: 10),
                        pw.Text('Valor: ${i.valor}'),
                        pw.SizedBox(height: 10),
                        pw.Container(height: 1, width: 130, color: PdfColors.black),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(i.nomeGrupo),
                        pw.SizedBox(height: 10),
                        pw.Container(height: 1, width: 130, color: PdfColors.black),
                        pw.SizedBox(height: 10),
                        pw.Text(i.nomeresponsavel),
                        pw.SizedBox(height: 10),
                        pw.Container(height: 1, width: 130, color: PdfColors.black),
                        pw.SizedBox(height: 10),
                        pw.Text('CPF: ${i.cpf}'),
                        pw.SizedBox(height: 10),
                        pw.Container(height: 1, width: 130, color: PdfColors.black),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 20),
                  pw.Image(netImage, height: 100),
                ],
              ),
            ],
          ),
          pw.Row(
            children: [],
          ),
        ],
      ),
    );
  }

  await pdf.save();
  await Printing.sharePdf(bytes: await pdf.save(), filename: 'my-document.pdf');
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  return pdf.save();
}

class Printter {
  final int parcela;
  final String vencimento;
  final double valor;
  final String nomeGrupo;
  final String nomeresponsavel;
  final String cpf;
  final String image;

  Printter({
    required this.parcela,
    required this.vencimento,
    required this.valor,
    required this.nomeGrupo,
    required this.nomeresponsavel,
    required this.cpf,
    required this.image,
  });
}
