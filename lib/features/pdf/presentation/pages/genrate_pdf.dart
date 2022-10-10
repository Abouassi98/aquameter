/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../data/report_model.dart';

Future generateReport(List<ReportData> data) async {
  const tableHeaders = [
    'Date',
    'ammonia',
    'Ph',
    'temperature',
    'salinity',
    'oxygen',
  ];

  // Some summary maths

  const baseColor = PdfColors.cyan;

  // Create a PDF document.
  final document = pw.Document();

  final theme = pw.ThemeData.withFont(
    base: await PdfGoogleFonts.openSansRegular(),
    bold: await PdfGoogleFonts.openSansBold(),
  );

  // Top bar chart

  // Left curved line chart

  // Data table
  final table = pw.Table.fromTextArray(
    border: null,
    headers: tableHeaders,
    data: List.generate(
      data.length,
      (index) => <dynamic>[
        data[index].realDate!.substring(0, 10),
        data[index].ammonia,
        data[index].ph,
        data[index].temperature,
        data[index].salinity,
        data[index].oxygen,
      ],
    ),
    headerStyle: pw.TextStyle(
      color: PdfColors.white,
      fontWeight: pw.FontWeight.bold,
    ),
    headerDecoration: const pw.BoxDecoration(
      color: baseColor,
    ),
    rowDecoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: baseColor,
          width: .5,
        ),
      ),
    ),
    cellAlignment: pw.Alignment.centerRight,
    cellAlignments: {0: pw.Alignment.centerLeft},
  );

  // Add page to the PDF
  document.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      theme: theme,
      build: (context) {
        return pw.Column(
          children: [
            pw.Text(
              '${data[0].client!.name} Report',
              style: const pw.TextStyle(
                color: baseColor,
                fontSize: 40,
              ),
            ),
            table,
          ],
        );
      },
    ),
  );

  // Return the PDF file content
  return await Printing.sharePdf(
      bytes: await document.save(), filename: 'my-document.pdf');
}
