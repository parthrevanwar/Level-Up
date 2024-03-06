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

class SignInWithEmailAndPasswordFailure {
  final String message ;

  SignInWithEmailAndPasswordFailure([this.message="an Unknown error occurred."]);


  factory SignInWithEmailAndPasswordFailure.code(String code){
    switch(code){
      // case 'user-not-found' :
      //   return SignInWithEmailAndPasswordFailure('No user found for that email.');
      // case 'invalid-email' :
      //   return SignInWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
      // case 'invalid-credential' :
      //   return SignInWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
      // case 'wrong-password' :
      //   return SignInWithEmailAndPasswordFailure('Wrong password provided for that user.');
      // case 'operation-not-allowed' :
      //   return SignInWithEmailAndPasswordFailure('operation is not allowed please contact support.');
      // case 'user-disabled' :
      //   return SignInWithEmailAndPasswordFailure('This user has been disabled. Please contact support for help.');
      default :
        return SignInWithEmailAndPasswordFailure(code);
    }
  }
}