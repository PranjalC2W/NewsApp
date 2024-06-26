
import 'package:firebase_auth/firebase_auth.dart';





class  FetchData{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
         await user.updateDisplayName(name);
         await user.reload();
          user = _auth.currentUser;
           return user;
        // await _firestore.collection('users').doc(user.uid).set({
        //   'uid': user.uid,
        //   'name': name,
        //   'email': email,
        // });
      }
       else{
        return null;
       }
    
    }on FirebaseAuthException catch (e) {
      print("Error: $e");
      return null;
    }
    
     catch (e) {
      print("Error:$e");
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  
}
