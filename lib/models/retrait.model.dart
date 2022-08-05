class Retrait {
  String? num_envoi;
  String? montant_envoi;
  String? devise;
  String? expediteur;
  String? beneficiaire;
  String? phone;
  String? dates;

  String? pays;

  Retrait(
      {this.num_envoi,
      this.montant_envoi,
      this.devise,
      this.expediteur,
      this.beneficiaire,
      this.phone,
      this.pays,
      this.dates});

  factory Retrait.fromJson(Map<String, dynamic> json) {
    return Retrait(
        num_envoi: json['num_envoi'],
        montant_envoi: json['montant'],
        devise: json['devise'],
        expediteur: json['expediteur'],
        beneficiaire: json['beneficiaire'],
        phone: json['phone'],
        pays: json['pays'],
        dates: json['dates']);
  }
}
