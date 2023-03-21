import 'package:appointment/models/user_model.dart' as model;
import 'package:flutter/material.dart';

import '../services/auth_services.dart';

class UserDetailsProvider extends ChangeNotifier {
  final auth = AuthServices();
  model.User? _user;

  model.User? get user => _user;

  Future<void> getUserDetails() async {
    final data = await auth.getUserDetails();
    _user = model.User.fromJson(data);
    notifyListeners();
  }
}
