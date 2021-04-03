class UserModel {

  final String uid;

  UserModel({ this.uid });

}

class UserData
{
  final String uid;
  final String plantName;
  final String plantType;
  final int waterTime;

  UserData({this.uid, this.plantType, this.plantName, this.waterTime});
}