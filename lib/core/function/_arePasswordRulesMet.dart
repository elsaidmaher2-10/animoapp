 import 'package:animoapp/core/resource/constantsmanager.dart';

bool arePasswordRulesMet() {
    return constantManager.passwordRules.every(
      (rule) => rule["status"] == true,
    );
  }