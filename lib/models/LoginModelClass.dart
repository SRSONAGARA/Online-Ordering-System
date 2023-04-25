class LoginModelClass {
  int status;
  String msg;
  LoginData data;

  LoginModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory LoginModelClass.fromJson(dynamic json) {
    return LoginModelClass(
        status: json['status'] ?? 0,
        msg: json['msg'] ?? '',
        data: LoginData.fromJson(json['data']));
  }
}

class LoginData {
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

  LoginData(
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

  factory LoginData.fromJson(dynamic json) {
    return LoginData(
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
