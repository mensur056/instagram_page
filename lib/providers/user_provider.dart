import 'package:flutter/material.dart';
import 'package:instagram_page/resource/auth_methods.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetailse();
    _user = user;
    notifyListeners();
  }
}
