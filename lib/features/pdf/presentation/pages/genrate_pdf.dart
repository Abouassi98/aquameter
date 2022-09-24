///Package imports

import 'package:aquameter/features/pdf/presentation/manager/save_file.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

///Pdf import
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/services/storage_service.dart';
import '../../../../core/utils/sizes.dart';
import '../../data/report_model.dart';

class PdfGenerator {
  Future<List<int>> readFontData() async {
    final ByteData bytes = await rootBundle.load('assets/fonts/arial.ttf');
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  Future<void> generatePDF(List<ReportData> reportData) async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    PdfFont font = PdfTrueTypeFont(await readFontData(),
        Sizes.fullScreenWidth(NavigationService.context) * .015);
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));
    //Generate PDF grid.
    final PdfGrid grid = _getGrid(font, reportData);

    //Draw the header section by creating text element
    final PdfLayoutResult result = _drawHeader(page, pageSize, grid);
    //Draw grid
    _drawGrid(page, grid, result);
    //Add invoice footer
    _drawFooter(page, pageSize);
    //Save and dispose the document.
    final List<int> bytes = await document.save();
    document.dispose();
    //Launch file.
    await saveAndLaunchFile(bytes, 'Report.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult _drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'Report', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));
    page.graphics.drawString(
        r'' '1255', PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'User Number: ${StorageService.instance.restoreUserData().data!.phone!}\r\n\r\nDate: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String address =
        'user info: \r\n\r\n${StorageService.instance.restoreUserData().data!.name} \r\n\r\n${StorageService.instance.restoreUserData().data!.email!} \r\n\r\n';
    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));
    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  //Draws the grid
  void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {};
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
  }

  //Draw the invoice footer data.
  void _drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));
    const String footerContent =
        'For Application support .\r\n\r\n+20 106 907 2590\r\n\r\n  support@aquameter-eg.com';
    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid _getGrid(font, List<ReportData> reportData) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 13);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.style.font = font;
    // headerRow.style.font = PdfFont[];
    headerRow.cells[0].value = 'Date';
    headerRow.cells[1].value = 'ph';
    headerRow.cells[2].value = 'Temperature';
    headerRow.cells[3].value = 'oxygen';
    headerRow.cells[4].value = 'salinity';
    headerRow.cells[5].value = 'ammonia';
    headerRow.cells[6].value = 'Toxic Ammonia';
    headerRow.cells[7].value = 'Fish Number';
    headerRow.cells[8].value = 'Total Weight';
    headerRow.cells[9].value = 'average Weight';
    headerRow.cells[10].value = 'Dead Fish';
    headerRow.cells[11].value = 'Total Feed';
    headerRow.cells[12].value = 'conversion Rate';
    // headerRow.cells[13].value = 'toxicAmmonia';

    for (var element in reportData) {
      addClient(
        realDate: element.realDate.toString().substring(0, 10),
        ph: element.ph.toString(),
        temperature: element.temperature.toString(),
        oxygen: element.oxygen.toString(),
        salinity: element.salinity.toString(),
        ammonia: element.ammonia.toString(),
        toxicAmmonia: element.toxicAmmonia.toString(),
        fishNumber: element.totalNumber.toString(),
        conversionRate: element.conversionRate.toString(),
        deadFish: element.deadFish.toString(),
        totalWeight: element.totalWeight.toString(),
        averageWeight: element.averageWeight.toString(),
        totalFeed: element.feed.toString(),
        grid: grid,
        font: font,
      );
    }

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    // grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 2, right: 2, top: 5);
      headerRow.cells[i].stringFormat.textDirection =
          PdfTextDirection.leftToRight;

      headerRow.cells[i].stringFormat.alignment = PdfTextAlignment.center;
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];

        cell.stringFormat.textDirection = PdfTextDirection.leftToRight;

        cell.stringFormat.alignment = PdfTextAlignment.center;

        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 2, right: 2, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addClient({
    required String realDate,
    required String ph,
    required String temperature,
    required String oxygen,
    required String toxicAmmonia,
    required String salinity,
    required String ammonia,
    required String fishNumber,
    required String totalWeight,
    required String averageWeight,
    required String deadFish,
    required String totalFeed,
    required String conversionRate,
    required PdfGrid grid,
    required PdfFont font,
  }) {
    final PdfGridRow row = grid.rows.add();
    row.style.font = font;
    row.cells[0].value = realDate;
    row.cells[1].value = ph;
    row.cells[2].value = temperature;
    row.cells[3].value = oxygen;
    row.cells[4].value = salinity;
    row.cells[5].value = ammonia;
    row.cells[6].value = toxicAmmonia;
    row.cells[7].value = fishNumber;
    row.cells[8].value = totalWeight;
    row.cells[9].value = averageWeight;
    row.cells[10].value = deadFish;
    row.cells[11].value = totalFeed;
    row.cells[12].value = conversionRate;
    // row.cells[13].value = ammonia;
  }
}
