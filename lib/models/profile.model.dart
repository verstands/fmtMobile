class Profil {
  int? id;
  String? matricule;
  String? nom;
  String? prenom;
  String? sexe;
  String? phone;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;

  Profil(
      {this.id,
      this.matricule,
      this.nom,
      this.prenom,
      this.sexe,
      this.phone,
      this.email,
      this.password,
      this.createdAt,
      this.updatedAt});

  Profil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matricule = json['matricule'];
    nom = json['nom'];
    prenom = json['prenom'];
    sexe = json['sexe'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['matricule'] = this.matricule;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['sexe'] = this.sexe;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
