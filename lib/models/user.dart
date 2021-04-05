class UserModel {

  final String uid;

  UserModel({ this.uid });

}

class UserData
{
  final String uid;
  final String name;
  final String bio;
  final int waterTime;
  final String email;

  UserData({this.uid, this.bio, this.name, this.waterTime, this.email});
}

class UserInfo {
  final String name;
  final String bio;
  final String email;
  final String uid;
  final int waterTime;

  UserInfo({this.name, this.bio, this.waterTime, this.email, this.uid});


}