class SaleWithClient {
  final String saleId;
  final DateTime date;
  final double totalAmount;
  final String? clientName;
  final String? clientImageUrl;

  SaleWithClient({
    required this.saleId,
    required this.date,
    required this.totalAmount,
    this.clientName,
    this.clientImageUrl,
  });
}
