import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database db;
Future<void> initDatabase() async {
  var path = await getDatabasePath('database04.db');
  db = await openDatabase(path, version: 3, onCreate: onCreate);
  print("bd creer");
}

Future<String> getDatabasePath(String dbName) async {
  var dataPath = await getDatabasesPath();
  var path = join(dataPath, dbName);
  return path;
}

Future onCreate(Database db, int version) async {
  await db.execute('''
          CREATE TABLE delegue (
            idDelegue INTEGER PRIMARY KEY AUTOINCREMENT,
            nomDelegue VARCHAR(50),
            matriculeDelegue VARCHAR(50),
            emailDelegue VARCHAR(50),
            passwordDelegue VARCHAR(50),
            niveauDelegue INT(15) NULL,
            cycleDelegue VARCHAR(50),
            filiereDelegue VARCHAR(50),
            optionDelegue VARCHAR(50),
            departement VARCHAR(50))
          ''');
  print("table  delegue creer");

  await db.execute('''
            CREATE TABLE cours (
            idCours INTEGER PRIMARY KEY AUTOINCREMENT,
            nomCours VARCHAR(50)  ,
            codeCours VARCHAR(50)  ,
            heuresToDo INT(15)  NULL,
            cm INT(15)  NULL,
            td INT(15)  NULL,
            tp INT(15)  NULL,
            idDelegue INT(15)  NULL,
            semestre INT(15)  NULL,
            nomEnseignant VARCHAR(50),
            FOREIGN KEY (idDelegue) REFERENCES delegue (idDelegue))
          ''');
  print("table cours creer");

  await db.execute('''
          CREATE TABLE emargement (
            idEmarg INTEGER PRIMARY KEY AUTOINCREMENT,
            repetition INT(15)  NULL,
            date_du_cours VARCHAR(50),
            signature_delegue VARCHAR(50),
            signature_enseignant VARCHAR(50),
            cm INT(15)  NULL,
            td INT(15)  NULL,
            tp INT(15)  NULL,
            FOREIGN KEY (repetition) REFERENCES cours (idCours))
          ''');
  print("table  emargement creer");

  await db.execute('''
            CREATE TABLE cours_delegue (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idDelegue INT(15) NOT NULL,
            idCours INT(15) NOT NULL,
            FOREIGN KEY (idDelegue) REFERENCES delegue (idDelegue),
            FOREIGN KEY (idCours) REFERENCES cours (idCours))
          ''');
  print("cours_delegue creer");
}
