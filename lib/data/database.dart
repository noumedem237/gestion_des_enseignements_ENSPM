import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseRepository {
  DatabaseRepository.privateConstructor();

  static final DatabaseRepository instance =
      DatabaseRepository.privateConstructor();

  final _databaseName = 'database8';
  final _databaseVersion = 3;

  static Database _database;

  // Future<Database> get database async {
  //   if (_database != null) {
  //     return _database;
  //   } else {
  //     _database = await _initDatabase();
  //   }
  // }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE delegue (
            idDelegue INTEGER PRIMARY KEY AUTOINCREMENT,
            nomDelegue VARCHAR(50),
            matriculeDelegue VARCHAR(50),
            emailDelegue VARCHAR(50),
            passwordDelegue VARCHAR(50),
            niveauDelegue INTEGER  NULL,
            cycleDelegue VARCHAR(50),
            filiereDelegue VARCHAR(50),
            optionDelegue VARCHAR(50),
            departement VARCHAR(50)
          )
          ''');
    await db.execute('''
          CREATE TABLE emargement (
            idEmarg INTEGER PRIMARY KEY AUTOINCREMENT,
            repetition INT  NULL,
            date_du_cours VARCHAR(50),
            nbre_heures INT NULL,
            signature_delegue VARCHAR(50),
            signature_enseignant VARCHAR(50)
          )
          ''');
    await db.execute(
        '''CREATE TABLE cours (
            idCours INTEGER PRIMARY KEY AUTOINCREMENT,
            nomCours VARCHAR(50)  ,
            codeCours VARCHAR(50)  ,
            heuresToDo INT  NULL,
            semestre INT  NULL,
            nomEnseignant VARCHAR(50) ,
            fkidDelegue INT NOT NULL,
            fkidEmarg INT  NOT NULL,
            FOREIGN KEY (fkidDelegue) REFERENCES delegue (idDelegue),           
            FOREIGN KEY (fkidEmarg) REFERENCES emargement (idEmarg) 
          )
          ''');
    print('inicall');
  }
}