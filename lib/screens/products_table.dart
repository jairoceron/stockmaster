import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '../data/database/local/app_database.dart';
import '../data/database/local/product_dao.dart';
import '../data/database/local/products.dart';

class ProductsTable extends StatefulWidget {
  const ProductsTable({Key? key}) : super(key: key);

  @override
  _ProductsTableState createState() => _ProductsTableState();
}

class _ProductsTableState extends State<ProductsTable> {
  late final AppDatabase _db;
  late final ProductDao _dao;
  List<ProductEntity> _products = [];
  List<ProductEntity> _filteredProducts = [];

  String _searchQuery = "";
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _db = AppDatabase();
    _dao = ProductDao(_db);
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final list = await _dao.getAllProducts();
    setState(() {
      _products = list;
      _filteredProducts = list;
    });
  }

  double _calculateMargin(double? purchasePrice, double? salePrice) {
    if (purchasePrice == null || purchasePrice <= 0 || salePrice == null) return 0;
    return ((salePrice - purchasePrice) / salePrice) * 100;
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      if (_searchQuery.isEmpty) {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products.where((p) {
          final values = [
            p.name ?? "",
            p.image ?? "",
            (p.stock ?? 0).toString(),
            (p.price ?? 0).toString(),
            (p.purchaseprice ?? 0).toString(),
          ];
          return values.any((v) => v.toLowerCase().contains(_searchQuery));
        }).toList();
      }
    });
  }

  void _onSort<T>(Comparable<T> Function(ProductEntity p) getField, int columnIndex, bool ascending) {
    setState(() {
      _filteredProducts.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
      });
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxDigits = _filteredProducts.isEmpty ? 2 : _filteredProducts.length.toString().length;

    return Column(
      children: [
        // 🔎 Buscador global
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: "Buscar...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: _onSearchChanged,
          ),
        ),
        Expanded(
          child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 700,
            dataRowHeight: 56,
            headingRowHeight: 48,
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              DataColumn2(
                label: const Text("N°"),
                size: ColumnSize.S,
                fixedWidth: maxDigits * 18.0,
                onSort: (i, asc) => _onSort((p) => p.id ?? "", i, asc),
              ),
              DataColumn(
                label: const Text("Nombre"),
                onSort: (i, asc) => _onSort((p) => p.name ?? "", i, asc),
              ),
              DataColumn(
                label: const Text("Imagen"),
                onSort: (i, asc) => _onSort((p) => p.image ?? "", i, asc),
              ),
              DataColumn(
                label: const Text("Stock"),
                numeric: true,
                onSort: (i, asc) => _onSort((p) => p.stock ?? 0, i, asc),
              ),
              DataColumn2(
                label: const Text("Precio venta"),
                size: ColumnSize.S,
                fixedWidth: 80,
                numeric: true,
                onSort: (i, asc) => _onSort((p) => p.price ?? 0, i, asc),
              ),
              DataColumn2(
                label: const Text("Precio compra"),
                size: ColumnSize.S,
                fixedWidth: 100,
                numeric: true,
                onSort: (i, asc) => _onSort((p) => p.purchaseprice ?? 0, i, asc),
              ),
              DataColumn(
                label: const Text("Margen"),
                numeric: true,
                onSort: (i, asc) => _onSort((p) => _calculateMargin(p.purchaseprice, p.price), i, asc),
              ),
            ],
            rows: List<DataRow>.generate(
              _filteredProducts.length,
                  (index) {
                final p = _filteredProducts[index];
                final truncatedName = (p.name ?? "")
                    .substring(0, (p.name ?? "").length > 30 ? 30 : (p.name ?? "").length);

                final margin = _calculateMargin(p.purchaseprice, p.price);

                return DataRow(
                  cells: [
                    DataCell(Text("${index + 1}")),
                    DataCell(Text(truncatedName)),
                    DataCell(Text(p.image ?? "Sin imagen")),
                    DataCell(Text("${p.stock ?? 0}")),
                    DataCell(Text("\$${(p.price ?? 0).toStringAsFixed(0)}")),
                    DataCell(Text("\$${(p.purchaseprice ?? 0).toStringAsFixed(0)}")),
                    DataCell(
                      SizedBox(
                        height: 40,
                        child: LinearProgressIndicator(
                          value: (margin.clamp(0, 100)) / 100,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            margin >= 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
