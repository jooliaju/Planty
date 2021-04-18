import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/user.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  //collection reference
  ///figure out how to get the uid of each plant doc
  final CollectionReference plantCollection =
      FirebaseFirestore.instance.collection('plants');

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

  Future updatePlant(String name) async {
    return await plantCollection.doc(uid).set({'name': name, 'uid': uid});
  }

  Future addPlant(String name, String bio, String type, DateTime nextWaterDate,
      String imageUrl) async {
    return await plantCollection.add({
      'name': name,
      'type': type,
      'bio': bio,
      'nextWaterDate': nextWaterDate,
      'imageUrl': imageUrl,
      'uid': uid
    });
  }

  // plant list from snapshot
  List<Plant> _plantListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Plant(
        name: doc.data()['name'] ?? "",
        bio: doc.data()['bio'] ?? "",
        nextWaterDate: doc.data()['nextWaterDate'].toDate() ?? null,
        type: doc.data()['type'] ?? "",
        imageUrl: doc.data()['imageUrl'] ?? "",
      );
    }).toList();
  }

  List<UserInfo> _userFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInfo(
        name: doc.data()['name'] ?? "",
        uid: doc.data()['uid'] ?? "",
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

  Stream<List<UserInfo>> get users {
    final Query currUserQuery = userCollection.where("uid", isEqualTo: uid);
    return currUserQuery.snapshots().map(_userFromSnapshot); //returns a stream
  }

  Stream<List<Plant>> get plants {
    final Query currUserPlants = plantCollection.where("uid", isEqualTo: uid);
    return currUserPlants
        .snapshots()
        .map(_plantListFromSnapshot); //returns a stream
  }

  //get user doc stream
  Stream<UserData> get userData {
    print("lol4 " + uid);

    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
