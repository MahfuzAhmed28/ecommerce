class WishListModel{
  final String id;
  final String productId;
  final String title;
  final List<String> photos;
  final double current_price;

  WishListModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.photos,
    required this.current_price
  });

  factory WishListModel.fromJson(Map<String,dynamic> jsonData){
    List<dynamic> photoList=jsonData['photos'] ?? [];

    return WishListModel(
        id: jsonData['_id'] ?? '',
        productId: jsonData['product']['_id'],
        title: jsonData['product']['title'] ?? '',
        photos: List<String>.from(photoList) ?? [],
        current_price: jsonData['current_price'] ?? 0.0
    );
  }



}