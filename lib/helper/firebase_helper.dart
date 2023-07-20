import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fsm_employee/helper/models/agenda_model.dart';
import 'package:fsm_employee/helper/models/user_model.dart';
import 'package:fsm_employee/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  final String _USER_COLLECTION = "Users";
  final String _AGENDA_COLLECTION = "Agenda";

  late FirebaseAuth _auth;
  late FirebaseFirestore _firebaseFirestore;
  late GoogleSignIn _googleSignIn;

  FirebaseHelper() {
    _firebaseFirestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn(
      clientId:
          "605689966498-h2d4k297kplomviiftm5sgm3qnqrdlv5.apps.googleusercontent.com",
      scopes: <String>[
        'email',
      ],
    );
  }

  Future<User?> loginWithGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      return authResult.user;
    }
    return null;
  }

  Future<List<String>> getAuthoriseUsers() async {
    List<String> emails = [];
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('Authorization').doc("email").get();
    var map = snapshot.data() as Map<String, dynamic>;
    emails = map["email"].cast<String>();
    return emails;
  }

  Future<void> registerUser(UserModel userModel) async {
    return await _firebaseFirestore
        .collection(_USER_COLLECTION)
        .doc(userModel.email)
        .set(
          userModel.toJson(),
          SetOptions(
            merge: true,
          ),
        );
  }

  Stream<List<AgendaModel>> showAgenda() {
    StreamController<List<AgendaModel>> agendaStream =
        StreamController<List<AgendaModel>>();
    _firebaseFirestore
        .collection(_AGENDA_COLLECTION)
        .snapshots()
        .listen((event) {
      List<AgendaModel> agendas = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> queryDocument
          in event.docs) {
        AgendaModel agendaModel = AgendaModel.fromJson(queryDocument.data());
        agendas.add(agendaModel);
      }
      if (!agendaStream.isClosed) {
        agendaStream.sink.add(agendas);
      }
    });
    return agendaStream.stream;
  }

  Future<void> addAgenda(AgendaModel agendaModel) async {
    return await _firebaseFirestore
        .collection(_AGENDA_COLLECTION)
        .doc("${agendaModel.timestamp}")
        .set(
          agendaModel.toJson(),
          SetOptions(
            merge: true,
          ),
        );
  }

  Future<List<AgendaModel>> myLeaves() async {
    UserModel userModel = await prefs.getUser();
    List<AgendaModel> leaves = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection(_AGENDA_COLLECTION)
        .where("user_email", isEqualTo: userModel.email)
        .orderBy("timestamp", descending: true)
        .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> queryDoc
        in querySnapshot.docs) {
      leaves.add(AgendaModel.fromJson(queryDoc.data()));
    }
    return leaves;
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<Map<String, dynamic>> getAppVersion() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('Version').doc("Version").get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> setUserToken(String token) async {
    return await _firebaseFirestore
        .collection(_USER_COLLECTION)
        .doc(_auth.currentUser?.email)
        .set(
      {"token": token},
      SetOptions(
        merge: true,
      ),
    );
  }
  Future<List<String>> getAdminTokens() async {
    List<String> emails = [];
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection('Admin').doc("tokens").get();
    var map = snapshot.data() as Map<String, dynamic>;
    emails = map["token"].cast<String>();
    return emails;
  }

  Future<void> deleteLeave(AgendaModel agendaModel) async {

    return await _firebaseFirestore
        .collection(_AGENDA_COLLECTION)
        .doc("${agendaModel.timestamp}")
        .set(
      agendaModel.toJson(),
      SetOptions(
        merge: true,
      ),
    );
  }

}
