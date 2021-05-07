import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/timeline_model.dart';
import 'package:planty_app/models/user.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String uid;
  final String plantId;

  DatabaseService({this.uid, this.plantId});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  //collection reference
  ///figure out how to get the uid of each plant doc
  final CollectionReference plantCollection =
      FirebaseFirestore.instance.collection('plants');

  final CollectionReference timelineCollection =
      FirebaseFirestore.instance.collection('timelines');


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
      int waterTime, String imageUrl) async {
    return await plantCollection.add({
      'name': name,
      'type': type,
      'bio': bio,
      'nextWaterDate': nextWaterDate,
      'waterTime': waterTime,
      'imageUrl': imageUrl,
      'uid': uid,
      'plantId': plantCollection.doc().id
    });
  }

  Future addTimeline({DateTime updatedAt, String imageUrl}) async {
    return await timelineCollection.add({
      'plantId': plantId,
      'imageUrl': imageUrl,
      'uid': uid,
      'updatedAt': updatedAt,
    });
  }

  // plant list from snapshot
  List<Plant> _plantListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Plant(
        plantId: doc.data()['plantId'] ?? '',
        name: doc.data()['name'] ?? "",
        bio: doc.data()['bio'] ?? "",
        nextWaterDate: doc.data()['nextWaterDate'].toDate() ?? null,
        waterTime: doc.data()['waterTime'] ?? 1,
        type: doc.data()['type'] ?? "",
        imageUrl: doc.data()['imageUrl'] ?? "",
      );
    }).toList();
  }

  //userData from snapshot

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

  //timeline data from snapshot

  List<TimelineModel> _timelineFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TimelineModel(
          updatedAt: doc.data()['updatedAt'].toDate() ?? null,
          imageUrl: doc.data()['imageUrl'] ?? "",
          plantId: doc.data()['plantId'] ?? "");
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

//get users stream

  Stream<List<UserInfo>> get users {
    final Query currUserQuery = userCollection.where("uid", isEqualTo: uid);
    return currUserQuery.snapshots().map(_userFromSnapshot); //returns a stream
  }

//get plants stream
  Stream<List<Plant>> get plants {
    final Query currUserPlants = plantCollection.where("uid", isEqualTo: uid);
    return currUserPlants
        .snapshots()
        .map(_plantListFromSnapshot); //returns a stream
  }

  Stream<List<TimelineModel>> get timelines {

    final Query currPlantTimeline =
        timelineCollection.where("plantId", isEqualTo: plantId).orderBy('updatedAt', descending: true);
    print("this the plant id " + plantId);
    return currPlantTimeline
        .snapshots()
        .map(_timelineFromSnapshot); //returns a stream
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}
