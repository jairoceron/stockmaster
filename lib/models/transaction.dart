class Transaction {
  final int? id;
  final String productId;
  final int cartGroupId;              // 👈 nuevo campo obligatorio
  final String transactionType;       // sale, purchase, adjustment
  final int quantity;
  final double? unitPrice;
  final double? totalAmount;
  final String? concept;
  final int? userId;
  final String? platform;
  final DateTime createdAt;

  // Auditoría y sincronización
  final bool syncStatus;
  final DateTime? lastSyncedAt;       // 👈 nuevo campo
  final String syncState;             // 👈 nuevo campo

  Transaction({
    this.id,
    required this.productId,
    required this.cartGroupId,
    required this.transactionType,
    required this.quantity,
    this.unitPrice,
    this.totalAmount,
    this.concept,
    this.userId,
    this.platform,
    required this.createdAt,
    required this.syncStatus,
    this.lastSyncedAt,
    this.syncState = 'pending',
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "cartGroupId": cartGroupId,
    "transactionType": transactionType,
    "quantity": quantity,
    "unitPrice": unitPrice,
    "totalAmount": totalAmount,
    "concept": concept,
    "userId": userId,
    "platform": platform,
    "createdAt": createdAt.toIso8601String(),
    "syncStatus": syncStatus,
    "lastSyncedAt": lastSyncedAt?.toIso8601String(),
    "syncState": syncState,
  };
}
