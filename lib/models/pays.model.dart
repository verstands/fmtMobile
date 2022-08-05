class Pays {
  int? id;
  String? nom;
  String? code;

  Pays({
    this.id,
    this.nom,
    this.code,
  });

  factory Pays.fromJson(Map<String, dynamic> json) {
    return Pays(id: json['id'], nom: json['nom'], code: json['code']);
  }
}
