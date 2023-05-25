import 'package:Despoky/utilities/assets.dart';


class AddToCartModel {
  final int id;
  final int productId;
  final String description;
  final String title;
  final int price;
  final String image;
  final String size;
  final int quantity;

  AddToCartModel( {
    required this.id,
    required this.description,
    required this.title,
    required this.price,
    required this.productId,
    required this.quantity,

    required this.image,
    required this.size,
  });
}


List<AddToCartModel> cartItem = [
  AddToCartModel(
    id: 1,
    productId: 3,
    title: "Piece one",
    price: 234,
    size: 'X',
    description: dummyText,
    quantity: 3,


    image: appAssets.product_1,
  ),
  AddToCartModel(
    id: 4,
    productId:2,
    title: "Piece five",
    description: dummyText,
    quantity: 5,

    price: 234,
    size: 'M',

    image: appAssets.product_4,
  ),
  AddToCartModel(
    id: 5,
    productId: 8,
    title: "Piece six",
    description: dummyText,

    quantity: 8,

    price: 234,
    size: 'X',

    image: appAssets.product_5,
  ),
  AddToCartModel(
    id: 6,
    productId: 9,
    title: "Piece seven",
    price: 234,
    description: dummyText,
    quantity: 10,

    size: 'XL',

    image: appAssets.product_6,

  ),
];
String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";