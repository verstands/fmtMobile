class Pays {
  int? id;
  String? nom;
  String? code_pays;

  Pays({
    this.id,
    this.nom,
    this.code_pays,
  });

  factory Pays.fromJson(Map<String, dynamic> json) {
    return Pays(id: json['id'], nom: json['nom'], code_pays: json['code_pays']);
  }
}
