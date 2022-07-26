class Devise {
  int? id;
  String? intitule;

  Devise({this.id, this.intitule});

  factory Devise.fromJson(Map<String, dynamic> json) {
    return Devise(
      id: json['id'],
      intitule: json['intitule'],
    );
  }
}
