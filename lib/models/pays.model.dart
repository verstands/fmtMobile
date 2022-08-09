class Pays {
  int? id;
  String? nom;
  String? codePays;
  String? createdAt;
  String? updatedAt;

  Pays({this.id, this.nom, this.codePays, this.createdAt, this.updatedAt});

  Pays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    codePays = json['code_pays'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['code_pays'] = this.codePays;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
