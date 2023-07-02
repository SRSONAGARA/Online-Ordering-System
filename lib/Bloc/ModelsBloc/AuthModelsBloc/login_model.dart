class LoginModelClassBloc {
  int status;
  String msg;
  LoginDataBloc data;

  LoginModelClassBloc({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory LoginModelClassBloc.fromJson(dynamic json) {
    return LoginModelClassBloc(
        status: json['status'] ?? 0,
        msg: json['msg'] ?? '',
        data: LoginDataBloc.fromJson(json['data']));
  }
}

class LoginDataBloc {
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

  LoginDataBloc(
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

  factory LoginDataBloc.fromJson(dynamic json) {
    return LoginDataBloc(
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
