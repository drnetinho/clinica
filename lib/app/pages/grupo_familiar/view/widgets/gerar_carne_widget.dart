import 'package:clisp/core/styles/text_app.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../../../../../core/styles/colors_app.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GerarCarneWidget extends StatelessWidget {
  const GerarCarneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pdfViewer(context, 'teste', 'teste ejnxjnjlnjn');
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

Future pdfViewer(
  BuildContext context,
  String title,
  String text,
) async {
  // Add your function code here!
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => pw.Column(
        children: [
          pw.Text(title),
          pw.SizedBox(height: 15),
          pw.Text(text),
        ],
      ),
    ),
  );
  // await file.writeAsBytes(await pdf.save());
  await pdf.save();
  await Printing.sharePdf(bytes: await pdf.save(), filename: 'my-document.pdf');
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  return pdf.save();
}
