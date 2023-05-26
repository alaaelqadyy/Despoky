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
}

List<ShippingAddress> shippingAddress = [
  ShippingAddress(id: '3', fullName: 'Fatma Rida', country: 'egypt', address: '6street', city: 'cairo', state: 'helwan', zipCode: 'demo')


];

