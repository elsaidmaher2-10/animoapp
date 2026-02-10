import 'package:animoapp/core/database/remote/error/failuerresponse.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';

String errorvalidator(Failuerresponse e) {
  List<String> errors = [];

  e.error.forEach((msg) {
    if (msg.contains(constantManager.emailrequired)) {
      errors.add(constantManager.emailrequired);
    }
    if (msg.contains(constantManager.passwordrequired)) {
      errors.add(constantManager.passwordrequired);
    }
    if (msg.contains(constantManager.phonerequired)) {
      errors.add(constantManager.phonerequired);
    }
    if (msg.contains(constantManager.firstnamerequired)) {
      errors.add(constantManager.firstnamerequired);
    }
    if (msg.contains(constantManager.lastnamerequired)) {
      errors.add(constantManager.lastnamerequired);
    }
    if (msg.contains(constantManager.invalidEmail)) {
      errors.add(constantManager.invalidEmail);
    }
    if (msg.contains(constantManager.invalidPhone)) {
      errors.add(constantManager.invalidPhone);
    }
    if (msg.contains(constantManager.invalidPassword)) {
      errors.add(constantManager.invalidPassword);
    }
    if (msg.contains(constantManager.emailAlreadyExists)) {
      errors.add(constantManager.emailAlreadyExists);
    }

    if (msg.contains(constantManager.Nointernetconnection)) {
      errors.add(constantManager.Nointernetconnection);
    }

    if (msg.contains("verfication code is required")) {
      errors.add("verfication code is required");
    }
    if (msg.contains("Invalid verfication code")) {
      errors.add("Invalid verfication code");
    }
  });

  return errors.join(" - ");
}
