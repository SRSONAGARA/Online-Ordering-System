class LoginModelClassGetx {
  int status;
  String msg;
  LoginDataGetx data;

  LoginModelClassGetx({
    required this.status,
    required this.msg,
     required this.data,
  });

  factory LoginModelClassGetx.fromJson(dynamic json) {
    return LoginModelClassGetx(
        status: json['status'] ?? 0,
        msg: json['msg'] ?? '',
        data: LoginDataGetx.fromJson(json['data']));
  }
}

class LoginDataGetx {
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

  LoginDataGetx(
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

  factory LoginDataGetx.fromJson(dynamic json) {
    return LoginDataGetx(
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
