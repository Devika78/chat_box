class UserModal {
  int id;
  String userName;
  String fullName;
  int phoneNo;
  String email;
  String birthday;
  String? profilePicUrl;
  String? bio;

  UserModal(this.id, this.userName, this.fullName, this.phoneNo, this.email,
      this.birthday, this.profilePicUrl, this.bio);

  UserModal.fromJson(json)
      : id = json['id'],
        userName = json['userName'],
        fullName = json['fullName'],
        phoneNo = json['phoneNo'],
        email = json['email'],
        birthday = json['birthday'],
        profilePicUrl = json['profilePicUrl'],
        bio = json['bio'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "fullName": fullName,
      "phoneNo": phoneNo,
      "email": email,
      "birthday": birthday,
      "profilePicUrl": profilePicUrl,
      "bio": bio
    };
  }
}
