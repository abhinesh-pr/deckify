class UserModel {
  final String uid;
  final String name;
  final String email;
  final String username; // Add username field

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.username, // Include username in constructor
  });

  // Convert UserModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'username': username, // Add username to the map
    };
  }

  // Convert Map to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      username: map['username'], // Extract username from map
    );
  }
}
