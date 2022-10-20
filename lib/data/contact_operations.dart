import 'package:sqflite/sqflite.dart';
import 'package:sqflite_tutorial/data/db.dart';
import 'package:sqflite_tutorial/models/contact.dart';

class ContactOperations {
  ContactOperations contactoperations;
  final Database dbProvider = db;
  int ui;
  void idcoursinternet() async {
    // ca marche
    final db = await dbProvider;
    List<Map> list = await db.rawQuery('SELECT idDelegue FROM delegue ');
    print("liste des idDelegue de tous les delegues : $list");
    dynamic i;
    if (await list[0]['idDelegue'] != null) {
      ui = await list[0]['idDelegue'];
      print("indice ui du delegue heberger : $ui");
    }
    //print("i de 0 vaut : $i");
    //ui = i;
  }

  Future<List<Map>> recupmatriculeDelegue() async {
    idcoursinternet(); // ne sert qu'a avoir ui
    final db = await dbProvider;
    if (ui == null) {
      return null;
    } else {
      List<Map> list = await db.rawQuery(
          'SELECT matriculeDelegue FROM delegue WHERE idDelegue= ?', ['$ui}']);
      return list;
    }
  }

  Future<List<Map>> recupnomCours() async {
    final db = await dbProvider;
    List<Map> list = await db.rawQuery('SELECT nomCours FROM cours');
    return list;
  }

  Future<List<Map>> recupmail() async {
    final db = await dbProvider;
    idcoursinternet();

    List<Map> list = await db.rawQuery(
        'SELECT emailDelegue FROM delegue WHERE idDelegue= ?', ['$ui']);

    return list;
  }

  Future<List<Map>> recuppass() async {
    final db = await dbProvider;
    idcoursinternet();
    print(" ui en password $ui");
    List<Map> list = await db.rawQuery(
        'SELECT passwordDelegue FROM delegue WHERE idDelegue= ?', ['$ui']);
    print(" le password vaut : ${list}");
    return list;
  }

  // Future<List<Map>> insertCours() async{
  //   final db = await dbProvider;
  //   idcoursinternet();
  //   List<Map> list = await db.rawQuery('SELECT passwordDelegue FROM delegue WHERE idDelegue= ?', ['$ui']);
  //   print(" cours vaut : ${list}");
  //   return list;
  // }

  Future<List<Map>> recupidcours() async {
    final db = await dbProvider;
    List<Map> list = await db.rawQuery('SELECT idCours FROM cours');
    print(" id de tous les cours : ${list}");
    return list;
  }

//======================== Cours/Contact ==========================================================
//   createCours(Contact cours) async {
//     final db = await dbProvider;
//     db.insert('cours', cours.toMap());
//     print('cours inserted');
//   }

  createCours(Contact cours) async {
    final db = await dbProvider;
    db.insert('cours', cours.toMap());
    //int  rr= idcoursinternet() as int ;
    idcoursinternet(); // que pour ui
    // await db.execute(
    //     'INSERT INTO cours_delegue (idDelegue, idCours) VALUES (?, ?)',
    //     ['$ui', '${cours.idCours}']);

    if (ui == null) {
      return null;
    } else {
      int count = await db.rawUpdate(
          'UPDATE cours SET idDelegue = ? WHERE idCours = ?',
          ['$ui', '${cours.idCours}']);
      print(count);
    }
    //db.update('emargement' , where: "idCours=?, idEmarg=?", whereArgs: [emargement.idCours, emargement.idEmargement]);
    List<Map> l = await db.rawQuery('SELECT * FROM cours');
    print("Liste de tous les cours: $l");
  }

  updateContact(Contact cours) async {
    final db = await dbProvider;
    db.update('cours', cours.toMap(),
        where: "idCours=?", whereArgs: [cours.idCours]);
    // db.update('emargement', emargement.toMap(), where: "idCours=?, idEmarg=?", whereArgs: [emargement.idCours, emargement.idEmargement]);
    List<Map> list = await db.rawQuery('SELECT * FROM cours');
    print("Liste de tous les cours update :$list");
  }

  insertion(int idcours, String date_du_cours, String signature_delegue,
      String signature_enseignant, int cm, int td, int tp) async {
    final db = await dbProvider;
    await db.execute(
        "INSERT INTO emargement (repetition, date_du_cours, cm, signature_delegue, signature_enseignant, td, tp) VALUES (?, ?, ?, ?, ?,?,?)",
        [
          '$idcours',
          '$date_du_cours',
          '$cm',
          '$signature_delegue',
          '$signature_enseignant',
          '$td',
          '$tp'
        ]);
    List<Map> list = await db.rawQuery(
        'SELECT idEmarg, repetition, date_du_cours, signature_delegue, signature_enseignant , cm, td, tp FROM emargement');
    print("Liste de tous les emargement :$list");
  }

  Future<List<Map>> hourloadcm(int t) async {
    final db = await dbProvider;
    // await db.execute("SELECT SUM (nbre_heures) WHERE repetition = ?",['$i']); ce type revoie un void
    List<Map> list = await db.rawQuery(
        'SELECT SUM(cm) FROM emargement WHERE repetition = ?', ['$t']);
    //int i= await list[0]['SUM(nbre_heures)'];
    // print('list : ${list[0]['SUM(nbre_heures)']}');
    //print("heure fait 2 :$i");
    return list;
  }

  Future<List<Map>> hourloadtd(int t) async {
    final db = await dbProvider;
    // await db.execute("SELECT SUM (td) WHERE repetition = ?",['$i']); ce type revoie un void
    List<Map> list = await db.rawQuery(
        'SELECT SUM(td) FROM emargement WHERE repetition = ?', ['$t']);
    //int i= await list[0]['SUM(nbre_heures)'];
    // print('list : ${list[0]['SUM(nbre_heures)']}');
    //print("heure fait 2 :$i");
    return list;
  }

  Future<List<Map>> hourloadtp(int t) async {
    final db = await dbProvider;
    // await db.execute("SELECT SUM (nbre_heures) WHERE repetition = ?",['$i']); ce type revoie un void
    List<Map> list = await db.rawQuery(
        'SELECT SUM(tp) FROM emargement WHERE repetition = ?', ['$t']);
    //int i= await list[0]['SUM(nbre_heures)'];
    // print('list : ${list[0]['SUM(nbre_heures)']}');
    //print("heure fait 2 :$i");
    return list;
  }

  Future<List<Map>> hourloadtpe(int t) async {
    final db = await dbProvider;
    // await db.execute("SELECT SUM (nbre_heures) WHERE repetition = ?",['$i']); ce type revoie un void
    List<Map> list = await db.rawQuery(
        'SELECT SUM(tpe) FROM emargement WHERE repetition = ?', ['$t']);
    //int i= await list[0]['SUM(nbre_heures)'];
    // print('list : ${list[0]['SUM(nbre_heures)']}');
    //print("heure fait 2 :$i");
    return list;
  }

  deleteCours(Contact cours) async {
    final db = await dbProvider;
    await db.delete('cours', where: 'idCours=?', whereArgs: [cours.idCours]);
  }

  Future<List<Contact>> getAllCours() async {
    final db = await dbProvider;
    print("Liste des cours test ");
    List<Map<String, dynamic>> allRows = await db.query('cours');
    print("Liste des cours brut $allRows ");
    List<Contact> courss =
        allRows.map((cours) => Contact.fromMap(cours)).toList();
    print("Liste des cours en toList() ${courss} ");
    return courss;
  }

  //Methode recuperation delegue
  Future<List<Delegue>> getDelegue() async {
    print("Liste des delegues test ");
    final db = dbProvider;
    // List<Map<String, dynamic>> allRows = await db.query('delegue');

    List<Map<String, dynamic>> allRows =
        await db.rawQuery(''' SELECT * FROM delegue ''');

    print("Liste brut  de tous les delegues  $allRows");
    List<Delegue> delegues = allRows.map((t) => Delegue.fromMap(t)).toList();
    print("Liste mappé de tous les delegues $delegues");
    // print("Liste des Delegues sqflite4 $allRows");
    // // if (delegue.length == 0) {
    // if (delegue.length == 0) {
    //   print("Liste des delegues sqflite $delegue");
    //   return null;
    // } else {
    //var u = delegues[0].idDelegue;
    // var u1 = allRows[0]["idDelegue"];
    // print("id mappe du delegue  : $u");
    // print("id brute du delegue: $u1");
    return delegues;
    //}
  }

  Future<List<Emargement>> getEmmargement(int id) async {
    final db = dbProvider;

    print("ton id la : $id");

    List<Map<String, dynamic>> emarg = await db
        .rawQuery('''SELECT * FROM emargement WHERE repetition = ${id} ''');
    List<Emargement> emarg1 =
        emarg.map((emargement) => Emargement.fromMap(emargement)).toList();
    print("les emargement brut : $emarg");
    print("les emargement  mappé : ${emarg1}");
    print("les emargement  en .repetition mappé : ${emarg1[0].repetition}");
    return emarg1;
  }

  Future<List<Contact>> searchCours(String keyword) async {
    final db = await dbProvider;
    List<Map<String, dynamic>> allRows = await db
        .query('cours', where: 'nomCours LIKE ?', whereArgs: ['%$keyword%']);
    List<Contact> cours =
        allRows.map((cours) => Contact.fromMap(cours)).toList();
    return cours;
  }

//======================== Cours/Contact ==========================================================

  // pour remplir les infos du delegue a son inscription
  createDelegue(
      int idDelegueInternet,
      String nomDelegue,
      String matriculeDelegue,
      String emailDelegue,
      String passwordDelegue,
      int niveauDelegue,
      String cycleDelegue,
      String filiereDelegue,
      String departement,
      String optionDelegue) async {
    final db = await dbProvider;
    // db.insert('delegue', delegue.toMap());
    await db.execute(
        'INSERT INTO delegue (idDelegue, nomDelegue, matriculeDelegue, emailDelegue, passwordDelegue, niveauDelegue, cycleDelegue, filiereDelegue, departement, optionDelegue) VALUES (?, ?,?, ?,?, ?,?, ?,?, ?)',
        [
          '$idDelegueInternet',
          '$nomDelegue',
          '$matriculeDelegue',
          '$emailDelegue',
          '$passwordDelegue',
          '$niveauDelegue',
          '$cycleDelegue',
          '$filiereDelegue',
          '$departement',
          '$optionDelegue'
        ]);
    List<Map> l = await db.rawQuery('SELECT * FROM delegue');
    print("Liste de tous les delegues: $l");
    print('delegue inserted');
  }

  // // pour permettre aux delegue et enseignant d'emarger. c'est la variable $repetition qui nous permettra d'emarger les differentes seances
  // updateEmargement(String date_du_cours, int nbre_heures, String signature_delegue, String signature_enseignant,int coursidcours) async {
  //   final db = await dbProvider;
  //   //db.update('emargement', emargement.toMap(), where: "idEmarg=? AND repetition=?", whereArgs: [emargement.idEmarg,i]);
  //   if(coursidcours==1){
  //
  //   }
  //   await db.rawUpdate('UPDATE emargement SET date_du_cours = ?, nbre_heures= ?, signature_delegue = ? ,signature_enseignant = ? WHERE idEmarg = ? AND repetition = ? ', ['$date_du_cours','$nbre_heures','$signature_delegue','$signature_enseignant','$coursidcours']);
  //
  //   List<Map> list = await db.rawQuery('SELECT idEmarg, repetition, date_du_cours, nbre_heures FROM emargement');
  //   print(list);
  // }

  // Future<void> insertRepetition(int index) async {
  //   int id2; int t;
  //   for(var i = 0; i< 3; i++){
  //      id2 = await db.rawInsert('INSERT INTO emargement (repetition) VALUES (?)', ['$index']);
  //       //await db.execute("INSERT INTO emargement (repetition) VALUES (?)",['$index']);
  //       //print("c'est entre");
  //   }
  //     List<Map> list = await db.rawQuery('SELECT repetition FROM emargement ');
  //     //List<Map> list = await db.rawQuery('SELECT idCours FROM cours');
  //     print(list);
  //   print("taille : ${list.length}");
  // }

}
