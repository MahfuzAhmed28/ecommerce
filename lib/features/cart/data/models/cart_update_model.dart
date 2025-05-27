class CartUpdateModel{
  final int quantity;

  CartUpdateModel({required this.quantity});

  Map<String,dynamic> toJson(){
    return{
      'quantity':quantity,
    };
  }
}