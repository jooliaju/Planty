import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  final String name;
  final String type;
  final String bio;
  final DateTime nextWaterDate;
  final String imageUrl;

  Plant({this.name, this.bio, this.imageUrl, this.type, this.nextWaterDate});
}
