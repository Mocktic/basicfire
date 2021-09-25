import 'dart:typed_data';

import 'package:contact/Models/UserModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Invoice {
  final pdf = pw.Document();

  Future<Uint8List> generatePdf(PdfPageFormat format, String title,
      double subtotal, UserModel userModel, String key) async {
    pdf.addPage(
      pw.Page(
          pageFormat: format,
          build: (context) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Center(
                        child: pw.Text(
                          "INVOICE",
                        ),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.only(right: 8, top: 10, left: 8),
                      child: pw.Text(
                        "Client name :- " +
                            userModel.firstName +
                            " " +
                            userModel.lastName,
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(horizontal: 8),
                      child: pw.Text(
                        "Client registed email :- " + userModel.email,
                      ),
                    ),
                    pw.Divider(),
                    pw.Divider(),
                    pw.Container(
                      padding: pw.EdgeInsets.only(right: 8, top: 2, left: 8),
                      child: pw.Text(
                        'Order Id: ' + key.toUpperCase(),
                      ),
                    ),
                    pw.Divider(),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          padding:
                              pw.EdgeInsets.only(right: 8, top: 2, left: 8),
                          child: pw.Text(
                            'Sub Total',
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.only(top: 2, right: 20),
                          child: pw.Text(
                            '\$' + subtotal.toStringAsFixed(2),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          padding:
                              pw.EdgeInsets.only(right: 8, top: 2, left: 8),
                          child: pw.Text(
                            'Sub Total',
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.only(top: 2, right: 20),
                          child: pw.Text(
                            '\$' + subtotal.toStringAsFixed(2),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          padding:
                              pw.EdgeInsets.only(right: 8, top: 2, left: 8),
                          child: pw.Text(
                            'Taxes Charges :- ',
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.only(top: 2, right: 20),
                          child: pw.Text(
                            '\$' + "${(subtotal * 19) / 100}",
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          padding:
                              pw.EdgeInsets.only(right: 8, top: 2, left: 8),
                          child: pw.Text(
                            'Net Payment :- ',
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.only(top: 2, right: 20),
                          child: pw.Text(
                            '\$' + "${(subtotal * 19) / 100 + subtotal}",
                          ),
                        ),
                      ],
                    ),
                    pw.Divider(),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          padding:
                              pw.EdgeInsets.only(right: 8, top: 2, left: 8),
                          child: pw.Text(
                            'Payment Mode:',
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.only(top: 2, right: 10),
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(5),
                            decoration: pw.BoxDecoration(),
                            child: pw.Center(
                              child: pw.Text(
                                'Online',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.only(
                          right: 20, top: 10, left: 20, bottom: 10),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        children: [
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Text(
                                'this is auto generated invoice',
                              ),
                              pw.Text(
                                'for more information contact us within 24 hours',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      height: 50,
                    )
                  ])),
    );
    return pdf.save();
  }
}
