// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:clisp/common/services/storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/core/helps/spacing.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/components/animated_resize.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ClispWallet extends StatelessWidget {
  final String groupName;
  final List<PatientModel> members;
  ClispWallet({
    Key? key,
    required this.groupName,
    required this.members,
  }) : super(key: key);

  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  String getNameAndSurname(String name) {
    final names = name.split(' ');
    return '${names[0]} ${names[names.length - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedResize(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: GestureDetector(
          onTap: () async {
            screenshotController.capture().then((image) async {
              if (image != null) {
                try {
                  final url = await StorageService.uploadToFirebase(image);

                  if (url?.isNotEmpty ?? false) {
                    // await pdfViewer(context, members, groupName, url!);
                    _launchUrl(url!);
                  }
                } catch (e) {
                  log(e.toString());
                }
              }
            });
          },
          child: Screenshot(
            controller: screenshotController,
            child: Container(
              width: 500,
              height: 300,
              decoration: BoxDecoration(
                gradient: context.colorsApp.greenGradient,
                color: context.colorsApp.greenDark2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.family_restroom, size: 40, color: context.colorsApp.dartWhite),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Carteira Clisp',
                              style: context.textStyles.textPoppinsBold
                                  .copyWith(fontSize: 18, color: context.colorsApp.dartWhite),
                            ),
                            Text(
                              groupName,
                              style: context.textStyles.textPoppinsBold
                                  .copyWith(fontSize: 14, color: context.colorsApp.greenDark),
                            ),
                          ],
                        )
                      ],
                    ),
                    Spacing.xs.verticalGap,
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GridView.builder(
                            itemCount: members.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 0.5,
                              childAspectRatio: 16 / 5,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getNameAndSurname(members[index].name),
                                    style: context.textStyles.textPoppinsSemiBold
                                        .copyWith(fontSize: 14, color: context.colorsApp.dartWhite),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'CPF: ${members[index].cpf}',
                                    style: context.textStyles.textPoppinsSemiBold
                                        .copyWith(fontSize: 12, color: context.colorsApp.greenDark),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future pdfViewer(BuildContext context, List<PatientModel> list, final String groupName, final String url) async {
    final pdf = pw.Document();

    final netImage = await networkImage(url);
    for (var i in list) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
            pw.Text(groupName),
            pw.Text(i.cpf),
            pw.Text(i.name),
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
}
