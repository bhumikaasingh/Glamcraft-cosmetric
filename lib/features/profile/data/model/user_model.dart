class UserModel {
  final String id;
  final String? firstName; // Made nullable
  final String? lastName; // Made nullable
  final String? contactNumber; // Made nullable
  final String email;
  final String? location; // Made nullable
  final String? profileImageUrl; // Made nullable

  UserModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.contactNumber,
    required this.email,
    this.location,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      contactNumber: json['contactNumber'] as String?,
      email: json['email'] ?? '',
      location: json['location'] as String?,
      profileImageUrl: json['profileImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'contactNumber': contactNumber,
      'email': email,
      'location': location,
      'profileImage': profileImageUrl,
    };
  }
}
