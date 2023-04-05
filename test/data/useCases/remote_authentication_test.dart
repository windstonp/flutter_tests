import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';

import 'package:fordev/domain/useCases/authentication.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = {"email": params.email, "password": params.secret};

    await httpClient.request(url: url, method: "post", body: body);
  }
}

abstract class HttpClient {
  Future<void> request({required String url, required String method, Map body});
}

class HttpCLientSpy extends Mock implements HttpClient {}

void main() {
  late HttpCLientSpy httpClient;
  late String url;
  late RemoteAuthentication sut;
  setUp(() {
    httpClient = HttpCLientSpy();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });
  test("Should call http client with correct values", () async {
    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());

    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: "post",
        body: {"email": params.email, "password": params.secret}));
  });
}
