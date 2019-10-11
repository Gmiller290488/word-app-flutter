class User {

  int id;
  String token;
  int userID;

  User({ this.id, this.token, this.userID});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"] as int,
        token: json["token"] as String,
        userID: json["userID"] as int,
    );
  }
}