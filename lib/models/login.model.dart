class Agence {
  int? id;
  String? email;
  String? password;
  String? token;

  Agence({
    this.id,
    this.token,
    this.email,
    this.password,
  });

  factory Agence.fromJson(Map<String, dynamic> json) {
    return Agence(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        token: json['token']);
  }
}
