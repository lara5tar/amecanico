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

/*
 * 
 *   palomita = done
 *   tacha = close
 *   f/s
 *   
 */

import 'dart:math';

import 'package:amecanico/3-Controlador/tickerpdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const String _MessageFooter =
    '(1)Todarevisiongeneracostosparasuelaboracion.(2)Todaslapiezasobservadasdurantelarevisionseencontraroncomoseexplican.(3)LafinalidaddetodaRevisionesdeterminarellugardondeseencuentraelproblema,antesdegenerarcambiosinnecesarios.(4)sirequierereparacionesadicionalesaplicancargosadicionales.(5)Todosnuestrospreciosson+iva16%.(6)Enparteselectricasnohaygarantiadeningunaespecie.';

Future<Uint8List> generateReporte(
  PdfPageFormat pageFormat, {
  required List<Map<String, dynamic>> ticket,
  required List<Map<String, dynamic>> items,
  required String tipoMantenimiento,
  required String domicilio,
  required String tel,
  required String fecha,
  required String cliente,
  required String datosGenerales,
}) async {
  final lorem = pw.LoremText();

  // final items = <Map<String, dynamic>>[
  //   {
  //     "tipo": "servicio",
  //     "nombre": "Afinación Mayor Completa",
  //   },
  //   {
  //     "tipo": "seccion",
  //     "nombre": "Cambio de Bujias",
  //   },
  //   {
  //     "tipo": "respuesta",
  //     "nombre": "normal",
  //     "seleccionado": "done",
  //   },
  //   {
  //     "tipo": "respuesta",
  //     "nombre": "Platino",
  //     "seleccionado": "No aplica",
  //   },
  //   {
  //     "tipo": "respuesta",
  //     "nombre": "Iridium",
  //     "seleccionado": "No aplica",
  //   },
  // ];

  final products = <Product>[];

  for (var p in ticket) {
    Product producto = Product(
      '1',
      p['nombre'],
      double.parse(p['seleccionado'].toString()),
      1,
    );
    products.add(producto);
  }

  final invoice = Reporte(
    invoiceNumber: Random().nextInt(999999).toString(),
    products: products,
    customerName:
        'Especialista en Electronica de Aviacion\nArturo E. Nieto Martinez',
    customerAddress:
        'Oaxaca# 403, Col. Fco. Javier Mina C.p.89318 Tampico, Tamps.',
    paymentInfo:
        'Arturo E. Nieto Martinez\nEspecialista en Electronica de Aviacion\nOaxaca# 403, Col. Fco. Javier Mina C.p.89318 Tampico, Tamps.\nCell: (833) 267 65 94 & (833) 312 71 99,\n(Email) Superarthus_74@outlook.com',
    tax: .16,
    baseColor: PdfColors.blue800,
    accentColor: PdfColors.blueGrey900,
    items: items,
    tipoMantenimiento: tipoMantenimiento,
    domicilio: domicilio,
    tel: tel,
    fecha: fecha,
    cliente: cliente,
    datosGenerales: datosGenerales,
  );
  return await invoice.buildPdf(pageFormat);
}

class Reporte {
  Reporte(
      {required this.products,
      required this.customerName,
      required this.customerAddress,
      required this.invoiceNumber,
      required this.tax,
      required this.paymentInfo,
      required this.baseColor,
      required this.accentColor,
      required this.items,
      required this.tipoMantenimiento,
      required this.domicilio,
      required this.tel,
      required this.fecha,
      required this.cliente,
      required this.datosGenerales});

  final List<Product> products;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final List<Map<String, dynamic>> items;
  final String cliente,
      fecha,
      domicilio,
      tel,
      tipoMantenimiento,
      datosGenerales;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  double get _total =>
      products.map<double>((p) => p.total).reduce((a, b) => a + b);

  double get _grandTotal => _total * (1 + tax);

  String? _logo;

  pw.MemoryImage? profileImage;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    //_logo = await rootBundle.loadString('assets/logo.png');
    // _bgShape = await rootBundle.loadString('assets/invoice.svg');
    profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );
    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _buildDatosGenerales(context),
          _buildItems(context),
          // pw.SizedBox(height: 20),
          //_contentHeader(context),
          // _contentTable(context),
          // pw.SizedBox(height: 20),
          // _contentFooter(context),
          // pw.SizedBox(height: 20),
          // _termsAndConditions(context),
        ],
      ),
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          // _buildDatosGenerales(context),
          // _buildItems(context),
          // pw.SizedBox(height: 20),
          // _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 0),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      '',
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 80,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: [
                          pw.Text(
                            'Reporte #',
                          ),
                          pw.Text(
                            invoiceNumber,
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text('Date:'),
                          pw.Text(
                            _formatDate(DateTime.now()),
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text('Página No.'),
                          pw.Text(
                            '${context.pageNumber} De ${context.pagesCount}',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 150,
                    child: profileImage != null
                        ? pw.Image(profileImage!)
                        : pw.PdfLogo(),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildTicket(pw.Context context) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 2),
      ),
      child: pw.Row(children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: items.map((e) {
              //servicio, seccion, respuesta
              return pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      e['nombre'],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }

  pw.Widget _buildItems(pw.Context context) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 2),
      ),
      child: pw.Row(children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: items.map((e) {
              //servicio, seccion, respuesta
              if (e['tipo'] == 'servicio') {
                return pw.Container(
                  padding: pw.EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                  ),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 2),
                  ),
                  child: pw.Text(
                    e['nombre'],
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                );
              } else if (e['tipo'] == 'seccion') {
                return pw.Container(
                  padding: pw.EdgeInsets.only(
                    left: 20,
                    top: 2,
                    bottom: 2,
                  ),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 2),
                  ),
                  child: pw.Text(
                    e['nombre'] + ':',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.normal,
                      fontStyle: pw.FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                );
              } else if (e['tipo'] == 'respuesta') {
                //nombre y seleccionado

                algo(s) => s == 'done'
                    ? '√'
                    : s == 'close'
                        ? 'X'
                        : s == 'fs'
                            ? 'f/s'
                            : s;

                return pw.Container(
                  padding: pw.EdgeInsets.only(
                    left: 60,
                    top: 5,
                    bottom: 5,
                  ),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 2),
                  ),
                  child: pw.Text(
                    e['nombre'] +
                        ': [ ' +
                        algo(e['seleccionado'].toString()) +
                        ' ]',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              }
              return pw.Container();
            }).toList(),
          ),
        ),
      ]),
    );
  }

  pw.Widget _buildDatosGenerales(pw.Context context) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 2),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          decoration: pw.BoxDecoration(
                            border:
                                pw.Border.all(color: PdfColors.black, width: 2),
                          ),
                          padding: pw.EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text('Cliente'),
                              pw.Text('Domicilio'),
                              pw.Text('Ciudad'),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: PdfColors.black, width: 2),
                            ),
                            // width: 385,
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                              children: [
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(
                                    left: 4,
                                  ),
                                  child: pw.Text(
                                    cliente,
                                    style: pw.TextStyle(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                ),
                                pw.Container(height: 1, color: PdfColors.black),
                                pw.Row(
                                  mainAxisSize: pw.MainAxisSize.max,
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  children: [
                                    pw.Expanded(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.only(
                                          left: 4,
                                        ),
                                        child: pw.Text(
                                          domicilio,
                                          style: pw.TextStyle(
                                            color: PdfColors.black,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                        width: 1,
                                        child: pw.Text(
                                          ' \' ',
                                          style: pw.TextStyle(
                                            color: PdfColors.white,
                                          ),
                                        ),
                                        color: PdfColors.black),
                                    pw.SizedBox(width: 11),
                                    pw.Text('Tel:'),
                                    pw.SizedBox(width: 11),
                                    pw.Container(
                                        width: 1,
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.only(
                                            left: 4,
                                          ),
                                          child: pw.Text(
                                            tel,
                                            style: pw.TextStyle(
                                              color: PdfColors.black,
                                              // fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        color: PdfColors.black),
                                    pw.Expanded(
                                      child: pw.Text(
                                        '\' ',
                                        textAlign: pw.TextAlign.right,
                                        style: pw.TextStyle(
                                          color: PdfColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                pw.Container(height: 1, color: PdfColors.black),
                                pw.Row(
                                  mainAxisSize: pw.MainAxisSize.max,
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  children: [
                                    pw.Expanded(
                                      child: pw.Text(
                                        'Tampico, Tamaulipas.',
                                        textAlign: pw.TextAlign.center,
                                      ),
                                    ),
                                    pw.Container(
                                        width: 1,
                                        child: pw.Text(
                                          ' \' ',
                                          style: pw.TextStyle(
                                            color: PdfColors.white,
                                          ),
                                        ),
                                        color: PdfColors.black),
                                    pw.SizedBox(width: 3),
                                    pw.Text('Fecha:'),
                                    pw.SizedBox(width: 3),
                                    pw.Container(
                                        width: 1,
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.only(
                                            left: 4,
                                          ),
                                          child: pw.Text(
                                            fecha,
                                            style: pw.TextStyle(
                                              color: PdfColors.black,
                                              // fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        color: PdfColors.black),
                                    pw.Expanded(
                                      child: pw.Text(
                                        '\' ',
                                        textAlign: pw.TextAlign.right,
                                        style: pw.TextStyle(
                                          color: PdfColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            child: pw.Text(
                              'Datos Generalesdel Vehiculo (Marca, Modelo, Año, Motor, Color, Vin, KmsoMillas, Placas)',
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: PdfColors.black, width: 2),
                            ),
                            child: pw.Text(
                              datosGenerales,
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                // fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          padding: pw.EdgeInsets.all(8),
                          decoration: pw.BoxDecoration(
                            border:
                                pw.Border.all(color: PdfColors.black, width: 2),
                          ),
                          child: pw.Text(
                            'Tipo de Mantenimiento',
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(8),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: PdfColors.black, width: 2),
                            ),
                            child: pw.Padding(
                              padding: pw.EdgeInsets.only(
                                left: 4,
                              ),
                              child: pw.Text(
                                tipoMantenimiento,
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  // fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            padding: pw.EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            child: pw.RichText(
                              text: pw.TextSpan(
                                text: 'Marcarcon ',
                                style: pw.TextStyle(
                                  fontSize: 10,
                                ),
                                children: [
                                  pw.TextSpan(
                                    text: 'X',
                                    style: pw.TextStyle(
                                      decoration: pw.TextDecoration.underline,
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text:
                                        ' las Partes Reemplazadas, Las Piezas Dañadascon ',
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: 'f/s',
                                    style: pw.TextStyle(
                                      decoration: pw.TextDecoration.underline,
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text:
                                        ' Y las que estan en Buenas Condiciones con una ',
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: '√',
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      decoration: pw.TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.pdf417(),
            data: 'CODIGO# $invoiceNumber',
            drawText: false,
          ),
        ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Text(''),
      ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            // margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: pw.FittedBox(
              child: pw.Text(
                'Total: ${_formatCurrency(_grandTotal)}',
                style: pw.TextStyle(
                  color: baseColor,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Reporte para:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: '$customerName\n',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                        const pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: customerAddress,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Gracias por su preferencia',
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  'Atendió:',
                  style: pw.TextStyle(
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                paymentInfo,
                style: const pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Sub Total:'),
                    pw.Text(_formatCurrency(_total)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Tax:'),
                    pw.Text('${(tax * 100).toStringAsFixed(1)}%'),
                  ],
                ),
                pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text(_formatCurrency(_grandTotal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: accentColor)),
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Terminos & Condiciones',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                _MessageFooter,
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        // pw.Expanded(
        //   child: pw.SizedBox(),
        // ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'CANTIDAD',
      'DESCRIPCIÓN',
      'TOTAL',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: _darkColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}

class Item {
  const Item(
    this.sku,
    this.productName,
    this.price,
    this.quantity,
  );

  static int counter = 0;
  final String sku;
  final String productName;
  final double price;
  final int quantity;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return (counter++).toString();
      case 1:
        return productName;
      case 2:
        return _formatCurrency(price);
      case 3:
        return quantity.toString();
      case 4:
        return _formatCurrency(total);
    }
    return '';
  }
}
