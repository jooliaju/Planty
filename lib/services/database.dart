import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference plantCollection =
      FirebaseFirestore.instance.collection('plants');

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');


  Future updateUserData(
      String username, String bio, int waterTime, email) async {
    return await userCollection.doc(uid).set({
      'name': username,
      'bio': bio,
      'waterTime': waterTime,
      'uid': uid,
      'email': email ?? ''
    });
  }
  // plant list from snapshot
  List<UserInfo> _plantListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return UserInfo(
        name: doc.data()['name'] ?? "",
        bio: doc.data()['bio'] ?? "",
        waterTime: doc.data()['waterTime'] ?? 0,
      );
    }).toList();
  }

  List<UserInfo> _userFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return UserInfo(
        name: doc.data()['name'] ?? "",
        bio: doc.data()['bio'] ?? "",
        waterTime: doc.data()['waterTime'] ?? 0,
      );
    }).toList();
  }



  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.data()['uid'],
      name: snapshot.data()['name'],
      bio: snapshot.data()['bio'],
      waterTime: snapshot.data()['waterTime'],
      email: snapshot.data()['email'],
    );
  }

//get plants stream
  Stream<List<UserInfo>> get plants {
    return plantCollection.snapshots().map(_plantListFromSnapshot); //returns a stream
  }

  Stream<List<UserInfo>> get users {
    return userCollection.snapshots().map(_userFromSnapshot); //returns a stream
  }


  //get user doc stream
  Stream<UserData> get userData {
    print("lol4 " + uid);
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }




}

