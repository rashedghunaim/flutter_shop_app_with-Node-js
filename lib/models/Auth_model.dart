import 'user_model.dart';

class AuthModel {
  String? msg;
  bool? status;
  UserModel? userData;
  AuthModel.getJson({required Map<String, dynamic> resData}) {
    msg = resData['msg'] ?? null;
    status = resData['status'] ?? null;
    userData =
        resData['user'] == null ? null : UserModel.getJson(resData['user']);
  }
}


