import 'package:uuid/uuid.dart';

class AppConstants {
  // Valor por defecto para idbusiness
  static const int defaultIdBusiness = 9999999;



  final uuid = const Uuid().v4();


 // static const int limit = 10;
 // static const int offset = 20;

  // Aquí puedes agregar más constantes globales
  static const String apiBaseUrl =
      'https://hsl36h9dj0.execute-api.us-east-2.amazonaws.com/dev';

  static const String GraphQL_endpoint=
      'https://vcb5i4iozffm5odzta6fywbarq.appsync-api.us-east-2.amazonaws.com/graphql';

  static const String real_time_endpoint=
  'wss://vcb5i4iozffm5odzta6fywbarq.appsync-realtime-api.us-east-2.amazonaws.com/graphql';

  // service that brings the product and the transactions.
  static const String queryMiel05 =
  "https://ywnu97diij.execute-api.us-east-2.amazonaws.com/dev/queryMiel05";

  static const String queryMiel06 =
  "https://hsl36h9dj0.execute-api.us-east-2.amazonaws.com/dev/queryMiel06";

}
