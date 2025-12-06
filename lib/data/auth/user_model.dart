// class UserModel {
//   final String uid;
//   final String name;
//   final String email;

//   UserModel({
//     required this.uid,
//     required this.name,
//     required this.email,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "uid": uid,
//       "name": name,
//       "email": email,
//     };
//   }

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       uid: json["uid"],
//       name: json["name"],
//       email: json["email"],
//     );
//   }
// }

class UserModel {
  final String uid;
  final String name;
  final String email;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
      );
}
