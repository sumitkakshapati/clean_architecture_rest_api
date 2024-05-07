import 'package:ferry/ferry.dart';
import 'package:flutter_clean_architecture_template/app/env.dart';
import 'package:flutter_clean_architecture_template/core/graphql/auth_link.dart';
import 'package:flutter_clean_architecture_template/core/injector/injection.dart';

class FerryUtils {
  static Client getFerryClient() {
    final link = HttpAuthLink(
      endPoint: DI.instance<Env>().baseUrl,
      getSlug: () async {
        return "";
      },
      getToken: () async {
        return "";
      },
    );
    return Client(
      link: link,
      defaultFetchPolicies: {
        OperationType.query: FetchPolicy.NetworkOnly,
      },
    );
  }
}
