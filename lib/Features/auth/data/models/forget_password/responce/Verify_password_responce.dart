/// status : "Success"

class VerifyPasswordResponce {
  VerifyPasswordResponce({
      this.status,});

  VerifyPasswordResponce.fromJson(dynamic json) {
    status = json['status'];
  }
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }

}