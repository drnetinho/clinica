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
  1,
  (index) => Printter(
    nome: 'Nome $index',
    cpf: 'CPF $index',
    grupo: 'Grupo $index',
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
        build: (context) => [
          pw.Text(i.nome),
          pw.Text(i.cpf),
          pw.Text(i.grupo),
          pw.Image(netImage),
          pw.Divider(),
        ],
      ),
    );
  }

  // await file.writeAsBytes(await pdf.save());
  await pdf.save();
  await Printing.sharePdf(bytes: await pdf.save(), filename: 'my-document.pdf');
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  return pdf.save();
}

class Printter {
  final String nome;
  final String cpf;
  final String grupo;
  final String image;
  Printter({
    required this.nome,
    required this.cpf,
    required this.grupo,
    required this.image,
  });
}
