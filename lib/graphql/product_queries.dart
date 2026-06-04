// lib/graphql/product_queries.dart

const String getProductsQuery = r'''
  query GetProducts {
    products {
      id
      idbusiness
      idcategory
      name
      image
      stock
      price
      created_at
      owner
      barcode
    }
  }
''';



const String

addProductMutation = r'''
  mutation AddProduct(
    $idbusiness: Int!,
    $idcategory: Int!,
    $name: String!,
    $image: String,
    $stock: Int!,
    $price: Float!,
    $owner: String,
    $barcode: String
  ) {
    addProduct(
      idbusiness: $idbusiness,
      idcategory: $idcategory,
      name: $name,
      image: $image,
      stock: $stock,
      price: $price,
      owner: $owner,
      barcode: $barcode
    ) {
      id
      idbusiness
      idcategory
      name
      image
      stock
      price
      created_at
      owner
      barcode
    }
  }
''';

const String deleteProductMutation = r'''
  mutation DeleteProduct($id: Int!) {
    deleteProduct(id: $id) {
      id
    }
  }
''';
