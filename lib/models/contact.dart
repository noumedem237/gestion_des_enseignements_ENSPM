//======================== COURS =====================================
class Contact {
  int idCours;
  String nomCours;
  String codeCours;
  int heuresToDo;
  int semestre;
  String nomEnseignant;
  int idDelegue;
  int td;
  int tp;
  int cm;

  Contact(
      {this.idCours,
      this.nomCours,
      this.codeCours,
      this.heuresToDo,
      this.semestre,
      this.idDelegue,
      this.nomEnseignant,
      this.cm,
      this.td,
      this.tp});

  Contact.fromMap(dynamic obj) {
    this.idCours = obj['idCours'];
    this.idDelegue = obj['idDelegue'];
    this.nomCours = obj['nomCours'];
    this.codeCours = obj['codeCours'];
    this.heuresToDo = obj['heuresToDo'];
    this.semestre = obj['semestre'];
    this.nomEnseignant = obj['nomEnseignant'];
    this.cm = obj['cm'];
    this.td = obj['td'];
    this.tp = obj['tp'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nomCours': nomCours,
      'idDelegue': idDelegue,
      'codeCours': codeCours,
      'heuresToDo': heuresToDo,
      'semestre': semestre,
      'nomEnseignant': nomEnseignant,
      'tp': tp,
      'cm': cm,
      'td': td,
    };

    return map;
  }
}

class Emargement {
  int idEmarg;
  int repetition;
  String date_du_cours;
  String signature_delegue;
  String signature_enseignant;
  int td;
  int tp;
  int cm;

  Emargement(
      {this.idEmarg,
      this.date_du_cours,
      this.signature_delegue,
      this.signature_enseignant,
      this.repetition,
      this.cm,
      this.td,
      this.tp});

  Emargement.fromMap(dynamic obj) {
    this.idEmarg = obj['idEmarg'];
    this.repetition = obj['repetition'];
    this.date_du_cours = obj['date_du_cours'];
    this.signature_delegue = obj['signature_delegue'];
    this.signature_enseignant = obj['signature_enseignant'];
    this.cm = obj['cm'];
    this.td = obj['td'];
    this.tp = obj['tp'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'repetition': repetition,
      'date_du_cours': date_du_cours,
      'signature_delegue': signature_delegue,
      'signature_enseignant': signature_enseignant,
      'tp': tp,
      'cm': cm,
      'td': td,
    };
    return map;
  }
}

//======================== DELEGUE =====================================
class Delegue {
  int idDelegue;
  String nomDelegue;
  String matriculeDelegue;
  String emailDelegue;
  String passwordDelegue;
  int niveauDelegue;
  String cycleDelegue;
  String filiereDelegue;
  String optionDelegue;
  String departement;

  // String get nameDelegue => nomDelegue;

  Delegue({
    this.idDelegue,
    this.nomDelegue,
    this.matriculeDelegue,
    this.emailDelegue,
    this.passwordDelegue,
    this.niveauDelegue,
    this.cycleDelegue,
    this.filiereDelegue,
    this.optionDelegue,
    this.departement,
  });

  Delegue.fromMap(dynamic obj) {
    this.idDelegue = obj['idDelelegue'];
    this.nomDelegue = obj['nomDelegue'];
    this.matriculeDelegue = obj['matriculeDelegue'];
    this.emailDelegue = obj['emailDelegue'];
    this.passwordDelegue = obj['passwordDelegue'];
    this.niveauDelegue = obj['niveauDelegue'];
    this.cycleDelegue = obj['cycleDelegue'];
    this.filiereDelegue = obj['filiereDelegue'];
    this.optionDelegue = obj['optionDelegue'];
    this.departement = obj['departement'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nomDelegue': nomDelegue,
      'matriculeDelegue': matriculeDelegue,
      'emailDelegue': emailDelegue,
      'passwordDelegue': passwordDelegue,
      'niveauDelegue': niveauDelegue,
      'cycleDelegue': cycleDelegue,
      'filiereDelegue': filiereDelegue,
      'optionDelegue': optionDelegue,
      'departement': departement
    };
    return map;
  }
}

class Cours_delegue {
  int id;
  int idDelegue;
  int idCours;

  Cours_delegue({
    this.id,
    this.idDelegue,
    this.idCours,
  });

  Cours_delegue.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.idDelegue = obj['idDelegue'];
    this.idCours = obj['idCours'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'idDelegue': idDelegue,
      'idCours': idCours,
    };
    return map;
  }
}
