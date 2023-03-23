import 'package:appointment/models/user_model.dart' as model;
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_services.dart';

class UserDetailsProvider extends ChangeNotifier {
  User? _user;
  final AuthServices _authMethods = AuthServices();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}