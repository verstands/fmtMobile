class Hystorique {
  String? montantEnvoi;
  String? intitule;
  String? expediteur;
  String? beneficiaire;
  String? phoneExp;
  String? nom;
  int? status;
  String? nomAgence;
  String? dates;
  String? stautR;
  String? idUserR;

  Hystorique(
      {this.montantEnvoi,
      this.intitule,
      this.expediteur,
      this.beneficiaire,
      this.phoneExp,
      this.nom,
      this.status,
      this.nomAgence,
      this.dates,
      this.idUserR,
      this.stautR});

  Hystorique.fromJson(Map<String, dynamic> json) {
    montantEnvoi = json['montant_envoi'];
    intitule = json['intitule'];
    expediteur = json['expediteur'];
    beneficiaire = json['beneficiaire'];
    phoneExp = json['phone_exp'];
    nom = json['nom'];
    status = json['status'];
    nomAgence = json['nom_agence'];
    dates = json['dates'];
    idUserR = json['idUserR'];
    stautR = json['stautR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['montant_envoi'] = this.montantEnvoi;
    data['intitule'] = this.intitule;
    data['expediteur'] = this.expediteur;
    data['beneficiaire'] = this.beneficiaire;
    data['phone_exp'] = this.phoneExp;
    data['nom'] = this.nom;
    data['status'] = this.status;
    data['nom_agence'] = this.nomAgence;
    data['dates'] = this.dates;
    data['idUserR'] = this.idUserR;
    data['stautR'] = this.stautR;

    return data;
  }
}
