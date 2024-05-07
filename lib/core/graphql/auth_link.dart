import 'package:gql_error_link/gql_error_link.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:gql_transform_link/gql_transform_link.dart';

typedef ValueCallBack = Future<String> Function();

class HttpAuthLink extends Link {
  final String endPoint;
  final ValueCallBack getToken;
  final ValueCallBack getSlug;
  String _token = "";
  String _slug = "";
  late Link _link;

  HttpAuthLink({
    required this.endPoint,
    required this.getToken,
    required this.getSlug,
  }) {
    _link = Link.concat(
      ErrorLink(onException: _handleException),
      TransformLink(requestTransformer: _transformRequest),
    );
    _link = _link.concat(HttpLink(endPoint));
  }

  Future<void> _updateCredentials() async {
    await _updateToken();
    await _updateSlug();
  }

  Future<void> _updateSlug() async {
    _slug = await getSlug();
  }

  Future<void> _updateToken() async {
    final String updatedToken = await getToken();
    if (updatedToken.isNotEmpty) {
      _token = updatedToken;
    }
  }

  //Used for refresh token
  Stream<Response> _handleException(
    Request request,
    NextLink forward,
    LinkException exception,
  ) async* {
    if (exception is HttpLinkServerException &&
        exception.response.statusCode == 401) {
      await _updateCredentials();

      yield* Link.concat(
        TransformLink(requestTransformer: _transformRequest),
        HttpLink(endPoint),
      ).request(request);

      return;
    }

    throw exception;
  }

  // Used to add headers and slug in the headers
  Request _transformRequest(Request request) =>
      request.updateContextEntry<HttpLinkHeaders>(
        (headers) {
          return HttpLinkHeaders(
            headers: <String, String>{
              ...headers?.headers ?? <String, String>{},
              if (_token.isNotEmpty) "Authorization": "Bearer $_token",
              "Slug": _slug,
            },
          );
        },
      );

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    if (_token.isEmpty || _slug.isEmpty) {
      await _updateCredentials();
    }
    yield* _link.request(request, forward);
  }
}
