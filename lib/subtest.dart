import 'dart:io';
import 'package:sqflite_tutorial/data/contact_operations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart'; // est un peut comme "import 'package:flutter/material.dart;" sauf que ceci permet travailler sur des pdf
import 'models/contact.dart';

ContactOperations contactoperations;

class PdfInvoiceApi {
  static Future<File> generate(
      Contact _cours,
      List<Delegue> _delegue,
      List<Emargement> tt,
      int realtimehour,
      int realtimehour1,
      int realtimehour2,
      int total) async {
    // pour generer un pdf
    final pdf = Document(); // creer un document pdf
    pdf.addPage(MultiPage(
      // tu ne peut pas mettre des widgets basique ici comme SizedBox ou container. tu dois creer un methode qui vas en contenir pour pouvoir les utilises
      build: (context) => [
        // c'est ici qu'on insere les grande parti de notre pdf
        buildHeader(_cours, tt, _delegue),
        SizedBox(height: 2 * PdfPageFormat.cm),
        //buildTitle(invoice), // partie du pdf contenant le titre
        buildInvoice(tt), // table des articles en tableau
        Divider(), // ligne de separation fine
        buildTotal(_cours, realtimehour, realtimehour1, realtimehour2,
            total), // total des articles
      ],
      footer: (context) => buildFooter(_cours),
    ));
    return PdfApi.saveDocument(name: '${_cours.nomCours}.pdf', pdf: pdf);
  }

  static Widget buildHeader(
          Contact _cours, List<Emargement> tt, List<Delegue> _delegue) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("FICHE DE SUIVI DES ENSEIGNEMENTS",
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(' Departement : ${_delegue[0].departement}'),
              Text(' Cycle : ${_delegue[0].cycleDelegue}'),
              Text(' Filiere : ${_delegue[0].filiereDelegue}'),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(' Option : ${_delegue[0].optionDelegue}'),
              Text(' Niveau : ${_delegue[0].niveauDelegue}'),
              Text(' Enseignant: ${_cours.nomEnseignant}'),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(' Cours: ${_cours.nomCours}'),
              Text(' Code: ${_cours.codeCours}'),
              Text('Semestre:${_cours.semestre}'),
              //buildCustomerAddress(invoice.customer),
              //buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

//   static Widget buildCustomerAddress(Customer customer) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
//           Text(customer.address),
//         ],
//       );

//   static Widget buildInvoiceInfo(InvoiceInfo info) {
//     final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
//     final titles = <String>[
//       'Invoice Number:',
//       'Invoice Date:',
//       'Payment Terms:',
//       'Due Date:'
//     ];
//     final data = <String>[
//       info.number,
//       Utils.formatDate(info.date),
//       paymentTerms,
//       Utils.formatDate(info.dueDate),
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(titles.length, (index) {
//         final title = titles[index];
//         final value = data[index];

//         return buildText(title: title, value: value, width: 200);
//       }),
//     );
//   }

//   static Widget buildSupplierAddress(Supplier supplier) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           Text(supplier.address),
//         ],
//       );

//   static Widget buildTitle(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // contient le titre,
//           Text(
//             'INVOICE',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//               height:
//                   0.8 * PdfPageFormat.cm), // espace de separattion entre textes
//           Text(invoice.info.description), // une description de invoice
//           SizedBox(height: 0.8 * PdfPageFormat.cm), // un espace
//         ],
//       );

  static Widget buildInvoice(List<Emargement> invoice) {
    // ca retourne un tableau
    print("mes invoice : ${invoice[0].date_du_cours}");
    final headers = [
      // je defini les entetes de mon tableau
      'Séances',
      'Date du cours',
      'Cours magistral',
      'Travaux Dirigés',
      'Travaux Pratique',
      'Signature Delegué',
      'Signature Enseignant',
    ];

    // final data = invoice.items.map((item) {
    //   // je defini les enregistrement de mon tableau
    //   final total = null; // calcul du prix total de tous les articles

    //   return [
    //     item.description, // la description
    //     '${item.quantity}', // quantié
    //     '\$ ${item.unitPrice}', // prix unitaire
    //     '${item.vat} %', // vat
    //     '\$ ${total.toStringAsFixed(2)}', // total (qui est converti ici en ....)
    //   ];
    // }).toList(); // on converti les enregistrement du tableau en list
    // new ListView.builder(
    //     itemCount: invoice.length,
    //     itemBuilder: (context, int index) {
    //       black = new Emargement(
    //         idEmarg: invoice[index].idEmarg,
    //         date_du_cours: invoice[index].date_du_cours,
    //         cm: invoice[index].cm,
    //         td: invoice[index].td,
    //         tp: invoice[index].tp,
    //         signature_enseignant: invoice[index].signature_enseignant,
    //         signature_delegue: invoice[index].signature_delegue,
    //       );

    //       return Text('');
    //     });
    //print("mes data : ${black}");
    // List<Emargement> t = black;
    // print("voyons voir :${black[0].signature_delegue}");
    final data = invoice.map((item) {
      return [
        item.idEmarg,
        item.date_du_cours,
        item.cm,
        item.td,
        item.tp,
        item.signature_delegue,
        item.signature_enseignant,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers, // j'insere rellement mes entetes du tableau
      data: data, // j'insere rellement les enregistrement du tableau
      border: null, // j'enleve les bordures
      headerStyle: TextStyle(
          fontWeight: FontWeight.bold), // on change le style de nos headers
      headerDecoration: BoxDecoration(
          color: PdfColors.grey300), // on change le style de nos headers colors
      cellHeight: 30, // la taille des elements entre les lignes
      cellAlignments: {
        // l'alignement de nos colonnes
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
      },
    );
  }

  static Widget buildTotal(Contact _cours, int realtimehour, int realtimehour1,
      int realtimehour2, int total) {
    int heureSup = 0;
    if (total > _cours.heuresToDo) {
      heureSup = total - _cours.heuresToDo;
    } else {
      heureSup = _cours.heuresToDo - total;
    }
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        // ligne pour afficher ces totaux
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "   Cours Magistral : $realtimehour /${_cours.cm}",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 10),
                Text("   Travaux Diriges : $realtimehour1 /${_cours.td}",
                    style: TextStyle(fontSize: 10)),
                SizedBox(height: 10),
                Text("   Travaux pratique : $realtimehour2 /${_cours.tp}",
                    style: TextStyle(fontSize: 10)),
                Divider(),
                Text("   Total : $total /${_cours.heuresToDo}",
                    style: TextStyle(fontSize: 10)),
                Divider(),
                Text("   Heures Supp : $heureSup",
                    style: TextStyle(fontSize: 10)),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Contact _cours) => Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text(' Visa Chef departement'),
          SizedBox(height: 1 * PdfPageFormat.mm),
          SizedBox(width: 20),
          Text(' Visa Chef de Division'),
        ],
      );

//   static buildSimpleText({
//     String title,
//     String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       // crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }

//   static buildText({
//     String title,
//     String value,
//     double width = double.infinity,
//     TextStyle titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
// }

}

class PdfApi {
  // classe pour enregistrer le document pdf
  static Future<File> saveDocument({
    String name,
    Document pdf,
  }) async {
    final bytes = await pdf.save(); // enregistrement proprement fait

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  } // pour le stocker localement

  static Future openFile(File file) async {
    // pour ouvrir notre pdf
    final url = file.path;

    await OpenFile.open(url); // OpenFile est un package flutter
  }
}
