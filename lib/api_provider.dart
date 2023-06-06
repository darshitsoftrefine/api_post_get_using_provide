import 'dart:developer';
import 'package:coupinos_api_get_using_provide/services.dart';
import 'package:flutter/cupertino.dart';

import 'model.dart';

class Api_Provider  extends ChangeNotifier {
  final Services _service = Services();
  bool isLoading = false;
  List<Post>? _contDetails;

  List<Post>? get contDetail => _contDetails;

  Future<void> getAllDetails() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.fetchpostDetails();
    _contDetails = response;

    isLoading = false;
    notifyListeners();
  }
}