class CreateReviewModel{
  final String firstName;
  final String lastName;
  final String review;

  CreateReviewModel({
    required this.firstName,
    required this.lastName,
    required this.review,
  });

  Map<String,dynamic> toJson(){
    return {
      'first_name': lastName,
      'last_name':lastName,
      'review':review,
    };
  }
}