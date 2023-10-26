import 'package:flutter/material.dart';
import 'package:quickly/screens/apicalls.dart';

class HomeProvider with ChangeNotifier {
  ApiCall apiCall = ApiCall();
  final List _usersList = [];

  List get usersList => _usersList;

  apiData(context, pageNo) async {
    final parsedData = await apiCall.fetchUsers(context, pageNo);

    _usersList.addAll(parsedData);
    notifyListeners();
  }

  notifiers() {
    notifyListeners();
  }
}
