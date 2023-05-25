class AddToCartModel {
  final int id;
  final int productId;
  final String description;
  final String title;
  final int price;
  final String image;
  final String size;
  final int quantity;

  AddToCartModel({
    required this.id,
    required this.productId,
    required this.description,
    required this.title,
    required this.price,
    required this.image,
    required this.size,
    required this.quantity,
  });
}