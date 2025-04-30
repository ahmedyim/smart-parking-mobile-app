class UserModel {
  String? uid;
  String? username;
  String? currentaddress;
  String? password;

  String? phone;

  UserModel({
    this.uid,
    this.username,
    this.currentaddress,
    this.password,
    this.phone,
  });

  // receiving data from server
  //
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      password: map['password'],
      currentaddress: map['currentaddress'],
      phone: map['phone'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'password': password,
      'currentaddress': currentaddress,
      'phone': phone,
    };
  }
}
