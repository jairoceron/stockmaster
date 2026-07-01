class ProductLot {
  final int? id;
  final String? lotenumber;
  final String? productid;
  final int? quantity;
  final DateTime? expirationdate;
  final DateTime? fabricationdate;

  ProductLot({
    this.id,
    this.lotenumber,
    this.productid,
    this.quantity,
    this.expirationdate,
    this.fabricationdate,
  });

  ProductLot copyWith({
    int? id,
    String? lotenumber,
    String? productid,
    int? quantity,
    DateTime? expirationdate,
    DateTime? fabricationdate,
  }) {
    return ProductLot(
      id: id ?? this.id,
      lotenumber: lotenumber ?? this.lotenumber,
      productid: productid ?? this.productid,
      quantity: quantity ?? this.quantity,
      expirationdate: expirationdate ?? this.expirationdate,
      fabricationdate: fabricationdate ?? this.fabricationdate,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'lotenumber': lotenumber,
    'productid': productid,
    'quantity': quantity,
    'expirationdate': expirationdate?.toIso8601String(),
    'fabricationdate': fabricationdate?.toIso8601String(),
  };

  factory ProductLot.fromJson(Map<String, dynamic> json) => ProductLot(
    id: json['id'] as int?,
    lotenumber: json['lotenumber'] as String?,
    productid: json['productid'] as String?,
    quantity: json['quantity'] as int?,
    expirationdate: json['expirationdate'] != null
        ? DateTime.parse(json['expirationdate'])
        : null,
    fabricationdate: json['fabricationdate'] != null
        ? DateTime.parse(json['fabricationdate'])
        : null,
  );
}
