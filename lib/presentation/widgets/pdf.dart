import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/models/contact.dart';
import 'mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class Pdf extends StatefulWidget {
  Contact cours;

  Pdf({Key key, this.cours}) : super(key: key);

  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('lib/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generation pdf"),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                  child: Text('Create PDF'),
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return MyApp();
                    // }));
                  }
// _createPDF,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _createPDF() async {
  //   PdfDocument document = PdfDocument();
  //   final PdfPage page = document.pages.add();
  //   document.pageSettings.orientation = PdfPageOrientation.landscape;

  //   page.graphics.drawImage(
  //       PdfBitmap(await _readImageData(
  //           "suivie.jpg")), // pour inserer une image dans un pdf
  //       Rect.fromLTWH(0, 0, 500, 200));

  //   PdfGrid grid = PdfGrid();

  //   grid.style = PdfGridStyle(
  //       font: PdfStandardFont(
  //           PdfFontFamily.helvetica, 20), // pour la taille et le style
  //       cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

  //   grid.columns.add(count: 9); //  set comlums
  //   grid.headers.add(4); // set the headers

  //   PdfGridRow header1 = grid.headers[0];
  //   header1.cells[0].value = 'Departement '; // ajout des valeurs des entetes
  //   header1.cells[1].value = "Filere ";

  //   PdfGridRow header2 = grid.headers[1];
  //   header2.cells[0].value = 'Cycle'; // ajout des valeurs des entetes
  //   header2.cells[1].value = "Diplome/ Diploma ";
  //   header2.cells[2].value = 'Specialité ';

  //   PdfGridRow header3 = grid.headers[2];
  //   header3.cells[0].value = 'Semestre '; // ajout des valeurs des entetes

  //   PdfGridRow header4 = grid.headers[3];
  //   header4.cells[0].value = 'Code UE'; // ajout des valeurs des entetes
  //   header4.cells[1].value =
  //       "Intitule des Unités d'\Enseignement (UE) / Course unit";
  //   header4.cells[2].value = 'CM';
  //   header4.cells[3].value = 'TD'; // ajout des valeurs des entetes
  //   header4.cells[4].value = "TP";
  //   header4.cells[5].value = 'TOTAL';
  //   header4.cells[6].value =
  //       "Nom et signature de l'\enseignant"; // ajout des valeurs des entetes
  //   header4.cells[7].value = "Nom et signature du Delegué";
  //   header4.cells[8].value = 'Date du cours';

  //   PdfGridRow row = grid.rows.add(); // pour une ligne
  //   row.cells[0].value = '1'; //
  //   row.cells[1].value = 'Arya'; // ajout de valeur dans cette ligne
  //   row.cells[2].value = '6'; //
  //   row.cells[3].value = '1'; //
  //   row.cells[4].value = 'Arya'; // ajout de valeur dans cette ligne
  //   row.cells[5].value = '6';
  //   row.cells[6].value = '1'; //
  //   row.cells[7].value = 'Arya'; // ajout de valeur dans cette ligne
  //   row.cells[8].value = '6';

  //   //  PdfGridRow rows = grid.rows.add();
  //   // rows.cells[0].value = '1'; // ajout des valeurs pour chaque colonne
  //   // rows.cells[1].value = 'Arya';
  //   // rows.cells[2].value = '6';

  //   grid.draw(
  //       page: page,
  //       bounds: Rect.fromLTWH(
  //           0, 250, page.getClientSize().width, page.getClientSize().height));
  //   //grid.draw(page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0)); // pour passer d'une page a l'autre

  //   //page.graphics.drawString('Visa du Chef de departement!', PdfStandardFont(PdfFontFamily.helvetica, 30)); // pour afficher tu texte
  //   //page.graphics.drawString('Visa du Chef de Division', PdfStandardFont(PdfFontFamily.helvetica, 30)); // pour afficher tu texte

  //   List<int> bytes = document.save();
  //   document.dispose(); // sauvegarder le pdf
  //   saveAndLaunchFile(bytes, 'Output. ${widget.cours.nomCours}.pdf');
  // }
}
