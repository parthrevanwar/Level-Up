


class SignUpWithEmailAndPasswordFailure {
  final String message ;

  SignUpWithEmailAndPasswordFailure([this.message="an Unknown error occurred."]);


  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password' :
        return SignUpWithEmailAndPasswordFailure('Please enter a strong password.');
      case 'invalid-email' :
        return SignUpWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
      case 'email-already-in-use' :
        return SignUpWithEmailAndPasswordFailure('AN account already exists for that email.');
      case 'operation-not-allowed' :
        return SignUpWithEmailAndPasswordFailure('operation is not allowed please contact support.');
      case 'user-disabled' :
        return SignUpWithEmailAndPasswordFailure('This user has been disabled. Please contact support for help.');
      default :
        return SignUpWithEmailAndPasswordFailure();
    }
  }
}