/// message : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NDkyNDc4ZTM2NGVmNjE0MDQyYjQ0NyIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzY2NDAyNDQ5fQ.2oS7Qf2lYDXQLOgVMLvPtnesVUNyk0dltGGi15aT2Ac"

class ResetPasswordResponce {
  ResetPasswordResponce({
      this.message, 
      this.token,});

  ResetPasswordResponce.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
  }
  String? message;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    return map;
  }

}