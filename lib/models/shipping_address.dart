import 'package:cloud_firestore/cloud_firestore.dart';

class ShippingAddress {
  final String id;
  final String fullName;
  final String country;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;

  ShippingAddress({
    required this.id,
    required this.fullName,
    required this.country,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    this.isDefault = false,
  });

  factory ShippingAddress.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ShippingAddress(
      id: doc.id,
      fullName: data['fullName'],
      country: data['country'],
      address: data['address'],
      city: data['city'],
      state: data['state'],
      zipCode: data['zipCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      fullName: 'fullName',
      country: 'country',
      address: 'address',
      city: 'city',
      state: 'state',
      zipCode:'zipCode',
    };
  }
}


List<ShippingAddress> shippingAddress = [
  ShippingAddress(id: '3', fullName: 'Alaa Elqady', country: 'egypt', address: '6street', city: 'cairo', state: 'helwan', zipCode: 'demo')


];