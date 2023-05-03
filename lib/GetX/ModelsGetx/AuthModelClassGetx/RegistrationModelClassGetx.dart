class SignupModelClassGetx {
  int status;
  String msg;
  SignUpDataGetx data;

  SignupModelClassGetx({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory SignupModelClassGetx.fromJson(dynamic json) {
    return SignupModelClassGetx(
        status: json['status'] ?? 0,
        msg: json['msg'] ?? '',
        data: SignUpDataGetx.fromJson(json['data']));
  }
}

class SignUpDataGetx {
  String id;
  String name;
  String mobileNo;
  String emailId;
  int status;
  String jwtToken;
  String fcmToken;
  String createdAt;
  String updatedAt;
  int v;

  SignUpDataGetx(
      {required this.id,
        required this.name,
        required this.mobileNo,
        required this.emailId,
        required this.status,
        required this.jwtToken,
        required this.fcmToken,
        required this.createdAt,
        required this.updatedAt,
        required this.v});

  factory SignUpDataGetx.fromJson(dynamic json) {
    return SignUpDataGetx(
      status: json['status'] ?? 0,
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      emailId: json['emailId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      jwtToken: json['jwtToken'] ?? '',
      fcmToken: json['fcmToken'] ?? '',
    );
  }
}
