/// email : "shahdehab798@gmail.com"
/// newPassword : "Shahd@1234"

class ResetPasswordRequest {
  ResetPasswordRequest({
      this.email, 
      this.newPassword,});

  ResetPasswordRequest.fromJson(dynamic json) {
    email = json['email'];
    newPassword = json['newPassword'];
  }
  String? email;
  String? newPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['newPassword'] = newPassword;
    return map;
  }

}