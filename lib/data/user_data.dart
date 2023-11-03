class UserProfile {
  String? email;
  String? fullName;
  String? uid;
  String? image;

  UserProfile({this.email, this.fullName, this.uid, this.image});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json['email'],
      fullName: json['fullName'],
      uid: json['uid'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'uid': uid,
      'image': image,
    };
  }
}