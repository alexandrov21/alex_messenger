class AppUser {
  final String fullName;
  final String email;
  final String? uid;

  AppUser({required this.fullName, required this.email, this.uid});

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'fullName': fullName, 'email': email};
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
    );
  }
}
