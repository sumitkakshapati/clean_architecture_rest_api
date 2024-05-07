import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_clean_architecture_template/core/constants/locale_keys.dart';
import 'package:flutter_clean_architecture_template/core/interface/graphql_client.dart';
import 'package:flutter_clean_architecture_template/core/model/custom_exception.dart';
import 'package:flutter_clean_architecture_template/core/model/graphql_response.dart';
import 'package:flutter_clean_architecture_template/core/utils/log_util.dart';
import 'package:flutter_clean_architecture_template/core/utils/text_utils.dart';
import 'package:gql_exec/gql_exec.dart';

class GraphqlClientImpl implements GraphqlClient {
  final Client client;
  GraphqlClientImpl({
    required this.client,
  });

  @override
  Future<GraphqlResponse<D>> sendRequest<D, V>(
    OperationRequest<D, V> request,
  ) async {
    try {
      /// ----- Sends the request
      final res = await client
          .request<D, V>(request)
          .firstWhere((e) => e.dataSource != DataSource.Optimistic);

      Log.info(res.operationRequest);
      if (res.graphqlErrors != null) {
        Log.error(res.graphqlErrors.toString());
      } else if (res.linkException != null) {
        Log.error(res.linkException.toString());
      } else {
        Log.debug(res.data.toString());
      }

      /// ------ Error Handler Start
      if (res.hasErrors) {
        if (res.graphqlErrors != null) {
          if (res.graphqlErrors!.isNotEmpty) {
            log('--- Graphql Error');
            throw CustomException(message: res.graphqlErrors!.first.message);
          }
        }
        throw CustomException(message: LocaleKeys.unexpectedErrorOccured.tr());
      }

      /// ----- Returns Response
      return GraphqlResponse<D>(data: res.data as D);
    } on GraphQLError catch (e) {
      throw CustomException(message: e.message);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  String? extractErrorIfExists(
    Map<String, dynamic>? message, {
    String? defaultMessage,
  }) {
    String data = defaultMessage ?? LocaleKeys.unexpectedErrorOccured.tr();
    if (message == null) {
      return null;
    }
    final x = message['message'];
    if (x != null) {
      if (x is String) {
        data = message['message'];
      }
    }
    final y = message['validationErrorMsg'];
    if (y != null) {
      if (y['message'] is String) {
        data = y['message'];
      }
    }

    return data.capitalize(allWords: false);
  }
}
