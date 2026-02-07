class constantManager {
  // ================== App ==================
  static const String animo = "ANIMOOO";

  // ================== Auth ==================
  static const String logIn = "Log In";
  static const String sinup = "Sign Up";
  static const String donthaveaccount = "Don’t have an account?";
  static const String Signup = "Sign up now";
  static const String retry = "retry";
  static const String forgetPassword = "Forget Password....?";

  // ================== Fields ==================
  static const String email = "Email";
  static const String pass = "Password";
  static const String phone = "Phone";
  static const String fname = "First Name";
  static const String lname = "Last Name";
  static const String confirmPassword = "Confirm Password";

  // ================== Hints ==================
  static const String hinytextemail = "Enter your email address";
  static const String hinytextpass = "********";
  static const String fnamehint = "Enter your First Name";
  static const String flnamehint = "Enter your Last Name";
  static const String phonehint = "Enter your Phone";
  static const String Nointernetconnection = "No internet connection";

  // ================== Required Errors ==================
  static const String firstnamerequired = "First name is required";
  static const String lastnamerequired = "Last name is required";
  static const String emailrequired = "Email is required";
  static const String passwordrequired = "Password is required";
  static const String phonerequired = "Phone is required";
  static const String imagerequired = "Image is required";

  // ================== Invalid Errors (API) ==================
  static const String invalidEmail = "Invalid email";
  static const String invalidPhone = "Invalid phone";
  static const String invalidPassword =
      "Password must be at least 6 characters and include letters and numbers and special characters";
  static const String emailAlreadyExists =
      "Email already exists or database error";
  // ================== Password Rules ==================
  static const String passwordRulestitle =
      "Please add all necessary characters to create safe password.";

  static List<Map<String, dynamic>> passwordRules = [
    {"title": "Minimum characters 12", "status": false},
    {"title": "One uppercase character", "status": false},
    {"title": "One lowercase character", "status": false},
    {"title": "One special character", "status": false},
    {"title": "One number", "status": false},
  ];

  // ================== Media ==================
  static const String photoGallery = "Photo Gallery";
  static const String camera = "Camera";
  static const String cancel = "Cancel";
}
