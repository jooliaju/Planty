import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planty_app/models/plant.dart';
import 'package:planty_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference plantCollection =
      FirebaseFirestore.instance.collection('plants');

  Future updateUserData(
      String plantName, String plantType, int waterTime) async {
    return await plantCollection.doc(uid).set({
      'plantName': plantName,
      'plantType': plantType,
      'waterTime': waterTime
    });
  }
  // plant list from snapshot
  List<Plant> _plantListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Plant(
        plantName: doc.data()['plantName'] ?? "",
        plantType: doc.data()['plantType'] ?? "",
        waterTime: doc.data()['waterTime'] ?? 0,
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      plantName: snapshot.data()['plantName'],
      plantType: snapshot.data()['plantType'],
      waterTime: snapshot.data()['waterTime']
    );
  }

//get plants stream
  Stream<List<Plant>> get plants {
    return plantCollection.snapshots().map(_plantListFromSnapshot); //returns a stream
  }


  //get user doc stream
  Stream<UserData> get userData {
    print("lol4 " + uid);
    return plantCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }




}

