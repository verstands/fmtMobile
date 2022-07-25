class Agence {
  int? id;
  String? matricule;
  String? prenom;
  String? sexe;
  String? email;
  String? password;
  String? token;

  Agence(
      {this.id,
      this.token,
      this.email,
      this.password,
      this.matricule,
      this.sexe,
      this.prenom});

  factory Agence.fromJson(Map<String, dynamic> json) {
    return Agence(
        id: json['agence']['id'],
        email: json['agence']['email'],
        password: json['agence']['password'],
        matricule: json['agence']['matricule'],
        sexe: json['agence']['sexe'],
        prenom: json['agence']['prenom'],
        token: json['agence']['token']);
  }
}
