class User {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;

  User({
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstname': firstname,
      'email': email,
      'lastname': lastname,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        uid: json['uid'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email']);
  }
}

class Space {
  String? freeSpace;

  Space({required this.freeSpace});

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      freeSpace: json['freeSpace'],
    );
  }
}
