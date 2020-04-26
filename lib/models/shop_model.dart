class ShopModel {
  final String name;
  final String address;
  final String phoneNumber;
  final String userId;

  ShopModel({this.name, this.address, this.phoneNumber, this.userId});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
      'user_id': userId,
    };
  }
}
