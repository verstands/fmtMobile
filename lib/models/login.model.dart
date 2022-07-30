class Agence {
  String? email;
  String? password;
  String? token;

  Agence({
    this.token,
    this.email,
    this.password,
  });

  factory Agence.fromJson(Map<String, dynamic> json) {
    return Agence(
        email: json['email'], password: json['password'], token: json['token']);
  }
}
