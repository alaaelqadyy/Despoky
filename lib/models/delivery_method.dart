import 'package:Despoky/utilities/assets.dart';

class DeliveryMethod {
  final String id;
  final String name;
  final String days;

  final String image;

  final int price;

  DeliveryMethod({
    required this.id,
    required this.name,
    required this.days,
    required this.image,

    required this.price,
  });
}


  List<DeliveryMethod> deliveryMethod = [
    DeliveryMethod(id: '1', name: 'car', days: '3',  price: 200, image: appAssets.delivery_1),
    DeliveryMethod(id: '3', name: 'motorcycle', days: '5', price: 345,image: appAssets.delivery_2),
    DeliveryMethod(id: '2', name: 'motorcycle', days: '2', price: 345,image: appAssets.delivery_3)


  ];

