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
  late AuthenticationParams params;

  setUp(() {
    httpClient = HttpCLientSpy();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
  });
  test("Should call http client with correct values", () async {
    when(httpClient.request(
            url: url,
            method: "post",
            body: {"email": params.email, "password": params.secret}))
        .thenAnswer((_) async =>
            {"accessToken": faker.guid.guid(), "name": faker.person.name()});
    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: "post",
        body: {"email": params.email, "password": params.secret}));
  });
  test("Should throw unexpected error if httpClient return 400", () async {
    when(httpClient.request(
            url: url,
            method: "post",
            body: {"email": params.email, "password": params.secret}))
        .thenThrow(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Should throw unexpected error if httpClient return 404", () async {
    when(httpClient.request(
            url: url,
            method: "post",
            body: {"email": params.email, "password": params.secret}))
        .thenThrow(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Should throw unexpected error if httpClient return 500", () async {
    when(httpClient.request(
            url: url,
            method: "post",
            body: {"email": params.email, "password": params.secret}))
        .thenThrow(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Should throw invalidCredential error if httpClient return 401",
      () async {
    when(httpClient.request(
            url: url,
            method: "post",
            body: {"email": params.email, "password": params.secret}))
        .thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test("Should return an account if httpClient return 200", () async {
    final accessToken = faker.guid.guid();
    when(httpClient.request(url: url, method: "post", body: {
      "email": params.email,
      "password": params.secret
    })).thenAnswer(
        (_) async => {"accessToken": accessToken, "name": faker.person.name()});

    final account = await sut.auth(params);

    expect(account.token, accessToken);
  });

  test(
      "Should throw unexpected error if httpClient return 200 with invalid data",
      () async {
    when(httpClient.request(
            url: url,
            method: "post",
            body: {"email": params.email, "password": params.secret}))
        .thenAnswer((_) async => {"invalid_key": "invalid_value"});
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
