class UserModel {
  String? id;
  String? username;
  String? password;
  String? sim;
  String? status;
  String? role;
  String? fullname;
  String? idgroup;

  UserModel({this.id, this.username, this.password, this.sim, this.status});
}

class LoginRequestModel {
  String? username;
  String? password;
  String? sim;
  String? date;
  LoginRequestModel({this.username, this.password, this.sim, this.date});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['sim'] = this.sim;
    data['date'] = this.date;

    return data;
  }
}




/// غير مستخدم
class LoginResponseModel {
  String? message;
  bool? status;
  LoginResponseModel(this.message, this.status);
}
