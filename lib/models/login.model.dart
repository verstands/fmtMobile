class Agence {
  String? access_token;

  Agence({this.access_token});

  Agence.fromJson(Map<String, dynamic> json) {
    access_token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.access_token;
    return data;
  }
}

class Agences {
  String? access_token;

  Agences({this.access_token});

  Agences.fromJson(Map<String, dynamic> json) {
    access_token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.access_token;
    return data;
  }
}
