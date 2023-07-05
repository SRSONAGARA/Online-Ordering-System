class SignupModelClassBloc {
  int status;
  String msg;
  SignUpDataBloc data;

  SignupModelClassBloc({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory SignupModelClassBloc.fromJson(dynamic json) {
    return SignupModelClassBloc(
        status: json['status'] ?? 0,
        msg: json['msg'] ?? '',
        data: SignUpDataBloc.fromJson(json['data']));
  }
}

class SignUpDataBloc {
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

  SignUpDataBloc(
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

  factory SignUpDataBloc.fromJson(dynamic json) {
    return SignUpDataBloc(
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
