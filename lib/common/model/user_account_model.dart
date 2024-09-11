class UserAccount {
  final BusinessProfile businessProfile;
  final User user;

  UserAccount({
    required this.businessProfile,
    required this.user,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      businessProfile: BusinessProfile.fromJson(json['businessProfile']),
      user: User.fromJson(json['user']),
    );
  }
}

class BusinessProfile {
  final String id;
  final String brandName;
  final String organizationName;
  final String address;
  final String city;
  final String pincode;
  final String emailId;
  final bool termsAgreed;

  BusinessProfile( {
    required this.id,
    required this.brandName,
    required this.organizationName,
    required this.address,
    required this.city,
    required this.pincode,
    required this.emailId,
    required  this.termsAgreed,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      id: json["_id"] ?? '',
      brandName: json['brandName'] ?? '',
      organizationName: json['organizationName'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      pincode: json['pincode'] ?? '',
      emailId: json['emailId'] ?? '',
        termsAgreed:json['termsAgreed'] ??''
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
