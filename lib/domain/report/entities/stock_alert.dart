class StockAlert {
  final String productId;
  final String message;

  StockAlert({
    required this.productId,
    required this.message,
  });

  factory StockAlert.fromJson(Map<String, dynamic> json) {
    return StockAlert(
      productId: json['productId'],
      message: json['message'],
    );
  }
}