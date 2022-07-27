class Depot {
  String? num_envoi;
  int? montant_envoi;
  int? devise;
  String? expediteur;
  String? beneficiaire;
  String? phone;
  int? agence;
  int? pays;

  Depot(
      {this.num_envoi,
      this.montant_envoi,
      this.devise,
      this.expediteur,
      this.beneficiaire,
      this.phone,
      this.agence,
      this.pays});

  factory Depot.fromJson(Map<String, dynamic> json) {
    return Depot(
        num_envoi: json['num_envoi'],
        montant_envoi: json['montant'],
        devise: json['devise'],
        expediteur: json['expediteur'],
        beneficiaire: json['beneficiaire'],
        phone: json['phone'],
        agence: json['agence'],
        pays: json['pays']);
  }
}
