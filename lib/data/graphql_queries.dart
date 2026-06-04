const String queryInventorySummary = r'''
query GetInventorySummary($idbusiness: Int!) {
  getInventorySummary(idbusiness: $idbusiness) {
    totalProductos
    stockTotal
    valorTotal
  }
}
''';

const String mutationUpdateSummary = r'''
mutation UpdateInventorySummary($idbusiness: Int!) {
  updateInventorySummary(idbusiness: $idbusiness) {
    totalProductos
    stockTotal
    valorTotal
  }
}
''';

const String subscriptionSummaryUpdated = r'''
subscription OnInventorySummaryUpdated($idbusiness: Int!) {
  onInventorySummaryUpdated(idbusiness: $idbusiness) {
    totalProductos
    stockTotal
    valorTotal
  }
}
''';
