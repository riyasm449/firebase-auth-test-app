const String NAME = 'name';
const String MOBILE = 'mobile_no';
const String MAIL = 'email';
const String PASSWORD = 'password';
const String CONFIRM_PASSWORD = 'password_confirm';
const String REFERAL_ID = 'referal_id';

class UserModel {
  final String name;
  final String mobile_no;
  final String email;
  final String password;
  final String referal_id;

  UserModel(
      {this.name, this.mobile_no, this.email, this.password, this.referal_id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json[NAME] ?? '',
        mobile_no: json[MOBILE] ?? '',
        email: json[MAIL] ?? '',
        password: json[PASSWORD] ?? '',
        referal_id: json[REFERAL_ID] ?? '');
  }

  Map<String, dynamic> toJson(UserModel model) {
    return {
      NAME: model.name,
      MOBILE: model.mobile_no,
      MAIL: model.email,
      PASSWORD: model.password,
      CONFIRM_PASSWORD: model.password,
      REFERAL_ID: model.referal_id
    };
  }
}
