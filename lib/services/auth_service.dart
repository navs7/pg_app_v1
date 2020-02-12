import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  //get UID
  Future<String> getCurrentUID()async{
    return (await _firebaseAuth.currentUser()).uid;
  }

  //email & password signup
  Future<String> createUserWithEmailandPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    //update username
    await updateUserName(name, currentUser);
    return currentUser.uid;
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
     var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  //email & password sigin
  Future<String> signInWithEmailandPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .uid;
  }

  //sign out
  signOut() {
    return _firebaseAuth.signOut();
  }

  //reset password
  Future sendPasswordResetEmail(String email)async{
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //create anonymous user
  Future signInAnonymously(){
    return _firebaseAuth.signInAnonymously();
  }
  
  Future convertUserWithEmail(String email, String password, String name)async{
    final currentUser = await _firebaseAuth.currentUser();
    final credential = EmailAuthProvider.getCredential(email:email,password:password);
    await currentUser.linkWithCredential(credential);
    await updateUserName(name, currentUser);
  }

  Future convertWithGoogle()async{
    final currentUser = await _firebaseAuth.currentUser();
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
    await currentUser.linkWithCredential(credential);
    await updateUserName(_googleSignIn.currentUser.displayName, currentUser);
  }

  //GOOGLE
  Future<String> signInWithGoogle()async{
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
    return (await _firebaseAuth.signInWithCredential(credential)).uid;
    
      }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 3) {
      return "Name must be 3 characters long";
    
    }
    if (value.length > 30) {
      return "Name must be less than 30 characters";
    
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    } 
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    } 
    return null;
  }
}
