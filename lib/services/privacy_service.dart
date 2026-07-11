import 'package:flutter/foundation.dart';

class PrivacyService extends ChangeNotifier {

  static final PrivacyService instance =
      PrivacyService._internal();

  PrivacyService._internal();

  bool _hideBalance = true;

  bool get hideBalance => _hideBalance;

  void toggleBalance() {

    _hideBalance = !_hideBalance;

    notifyListeners();

  }

}