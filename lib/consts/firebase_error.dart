class FirebaseError {
  static String handleException(e) {
    final String message;
    switch (e.code) {
      case 'email-already-in-use':
        message = "This email has already been used for another account.";
        break;
      case 'invalid-email':
        message = "The email address is invalid or does not exist.";
        break;
      case 'weak-password':
        message =
            "The password is too weak. Please choose a stronger password.";
        break;
      case 'invalid-credential':
        message = "The email or password is incorrect.";
        break;
      case 'user-disabled':
        message = "This user account has been disabled.";
        break;
      case 'user-not-found':
        message = "No user found with this information.";
        break;
      case 'wrong-password':
        message = "Wrong password. Please try again.";
        break;
      // Add more cases to handle other error codes as necessary
      default:
        message = "An undefined Error occurred: ${e.message}";
        break;
    }
    return message;
  }
}
