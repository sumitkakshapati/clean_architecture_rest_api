import 'package:ferry/ferry.dart';
import 'package:flutter_clean_architecture_template/core/model/graphql_response.dart';

abstract class GraphqlClient {
  Future<GraphqlResponse<D>> sendRequest<D, V>(OperationRequest<D, V> request);
  String? extractErrorIfExists(Map<String, dynamic>? message,
      {String? defaultMessage});
}
