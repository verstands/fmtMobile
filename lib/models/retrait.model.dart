class Retrait {
  int? id;
  String? code;
  String? montantEnvoi;
  int? idDevise;
  String? expediteur;
  String? beneficiaire;
  String? phoneExp;
  int? idPays;
  String? createdAt;
  String? updatedAt;
  String? dates;
  int? status;
  int? idAg;
  String? idUser;

  Retrait(
      {this.id,
      this.code,
      this.montantEnvoi,
      this.idDevise,
      this.expediteur,
      this.beneficiaire,
      this.phoneExp,
      this.idPays,
      this.createdAt,
      this.updatedAt,
      this.dates,
      this.status,
      this.idAg,
      this.idUser});

  Retrait.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    montantEnvoi = json['montant_envoi'];
    idDevise = json['id_devise'];
    expediteur = json['expediteur'];
    beneficiaire = json['beneficiaire'];
    phoneExp = json['phone_exp'];
    idPays = json['id_pays'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dates = json['dates'];
    status = json['status'];
    idAg = json['id_ag'];
    idUser = json['id_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['montant_envoi'] = this.montantEnvoi;
    data['id_devise'] = this.idDevise;
    data['expediteur'] = this.expediteur;
    data['beneficiaire'] = this.beneficiaire;
    data['phone_exp'] = this.phoneExp;
    data['id_pays'] = this.idPays;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['dates'] = this.dates;
    data['status'] = this.status;
    data['id_ag'] = this.idAg;
    data['id_user'] = this.idUser;
    return data;
  }
}
