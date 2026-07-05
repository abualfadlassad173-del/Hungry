class UserModel {
 final String name;
 final String email;
  final String? token;
  final String? address;
  final String? image;
  final String? visa;

  UserModel({
    required this.name,
    required this.email,
    this.token,
    this.address,
    this.image,
    this.visa,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        token: json['token'],
        address: json['address'],
        image: json['image'],
        visa: json['visa'] ?? json['Visa'],
      );
}