import 'package:flutter/material.dart' show ChangeNotifier;
import '../models/user.dart';
import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  late User _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user;

  Future<void> refreshUser() async {
    
    final User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
