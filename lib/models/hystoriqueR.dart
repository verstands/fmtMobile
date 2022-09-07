class hystoriqueR {
  int? montantEnvoi;
  String? intitule;
  String? expediteur;
  String? beneficiaire;
  String? phone;
  String? nom;
  String? dates;

  hystoriqueR(
      {this.montantEnvoi,
      this.intitule,
      this.expediteur,
      this.beneficiaire,
      this.phone,
      this.nom,
      this.dates});

  hystoriqueR.fromJson(Map<String, dynamic> json) {
    montantEnvoi = json['montant_envoi'];
    intitule = json['intitule'];
    expediteur = json['expediteur'];
    beneficiaire = json['beneficiaire'];
    phone = json['phone'];
    nom = json['nom'];
    dates = json['dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['montant_envoi'] = this.montantEnvoi;
    data['intitule'] = this.intitule;
    data['expediteur'] = this.expediteur;
    data['beneficiaire'] = this.beneficiaire;
    data['phone'] = this.phone;
    data['nom'] = this.nom;
    data['dates'] = this.dates;
    return data;
  }
}
