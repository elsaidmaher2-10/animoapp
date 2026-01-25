class constantManager {
  static const String animo = "ANIMOOO";
  static const String logIn = "Log In";
  static const String sinup = "Sign Up";
  static const String email = "Email";
  static const String fname = "First Name";
  static const String phone = "Phone";
  static const String lname = "Last Name";
  static const String pass = "Password";
  static const String hinytextemail = "Enter your email address";
  static const String hinytextpass = "********";
  static const String donthaveaccount = "Don’t have an account?";
  static const String Signup = "Sign up now";
  static const String fnamehint = "Enter your First Name";
  static const String flnamehint = "Enter your Last Name";
  static const String phonehint = "Enter your Phone";
  static const String ForgetPassword = "Forget Password....?";
  static const String confirmPassword = "Confirm Password";
  static const String PasswordRulestitle =
      "Please add all necessary characters to create safe password.";
  static List<Map<String, dynamic>> PasswordRules = [
    {"title": "Minimum characters 12", "status": false},
    {"title": "One uppercase character", "status": false},
    {"title": "One lowercase character", "status": false},
    {"title": "One special character", "status": false},
    {"title": "One number", "status": false},
  ];
}
