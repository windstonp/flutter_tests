// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';

import 'package:fordev/domain/useCases/usecases.dart';
import 'package:fordev/domain/helpers/helpers.dart';

import 'package:fordev/data/http/http.dart';
import 'package:fordev/data/useCases/usecases.dart';

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
  test("Should throw unexpected error if httpClient return 400", () async {
    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
    when(httpClient.request(
            url: url,
            method: "post",
            body: {"email": params.email, "password": params.secret}))
        .thenThrow(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
