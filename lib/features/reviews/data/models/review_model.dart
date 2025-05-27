class ReviewModel {
  final String id;
  final String productId;
  final String firstName;
  final String lastName;
  final String comment;
  final String imageUrl;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.firstName,
    required this.lastName,
    required this.comment,
    required this.imageUrl,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> jsonData) {
    return ReviewModel(
      id: jsonData['_id'],
      productId: jsonData['product']['_id'],
      firstName: jsonData['user']['first_name'],
      lastName: jsonData['user']['last_name'],
      comment: jsonData['comment'],
      imageUrl: (jsonData['product']['photos'] as List).isNotEmpty
          ? jsonData['product']['photos'][0]
          : '',
    );
  }
}
