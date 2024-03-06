class MyExceptions implements Exception{
  final String message;

  const MyExceptions([this.message='An unknown exception occured']);

  factory MyExceptions.fromCode(String code){
    switch(code){
      case 'email-already-in-use' :
        return const MyExceptions('AN account already exists for that email.');
      case 'invalid-email' :
        return const MyExceptions('Email is not valid or badly formatted.');
      case 'weak-password' :
        return const MyExceptions('Please enter a strong password.');
      case 'user-disabled' :
        return const MyExceptions('This user has been disabled. Please contact support for help.');
      case 'user-not-found' :
        return const MyExceptions('InValid Details, please create an account.');
      case 'wrong-password' :
        return const MyExceptions('Incorrect Password ,please try again');
      case 'too-many-requests' :
        return const MyExceptions('too many request,service Temporarily blocked');
      case 'invalid-argument' :
        return const MyExceptions('an invalid argumanet was provided to an authentication method');
      case 'invalid-phone-number' :
        return const MyExceptions('The provided phone number is invalid');
      case 'operation-not-allowed' :
        return const MyExceptions('The provided sign-in provider is disabled for your fire base project');
      case 'session-cookie-expired' :
        return const MyExceptions('The provided firebase session cookie is expired');
      case 'uid-already-exists' :
        return const MyExceptions('The provided uid is already in use');
      default :
        return const MyExceptions();
    }
  }
}