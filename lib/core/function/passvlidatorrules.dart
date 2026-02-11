import 'package:animoapp/core/resource/constantsmanager.dart';

List passwordvalidatorrules(String value) {
  if (value.trim().length >= 12) {
    constantManager.passwordRules[0]["status"] = true;
  } else {
    constantManager.passwordRules[0]["status"] = false;
  }
  if (value.contains(RegExp(r'[A-Z]'))) {
    constantManager.passwordRules[1]["status"] = true;
  } else {
    constantManager.passwordRules[1]["status"] = false;
  }
  if (value.contains(RegExp(r'[a-z]'))) {
    constantManager.passwordRules[2]["status"] = true;
  } else {
    constantManager.passwordRules[2]["status"] = false;
  }
  if (value.contains(RegExp(r'[0-9]'))) {
    constantManager.passwordRules[4]["status"] = true;
  } else {
    constantManager.passwordRules[4]["status"] = false;
  }
  if (value.contains(RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]{};:"\\|,.<>\/?]'))) {
    constantManager.passwordRules[3]["status"] = true;
  } else {
    constantManager.passwordRules[3]["status"] = false;
  }
  return constantManager.passwordRules;
}
