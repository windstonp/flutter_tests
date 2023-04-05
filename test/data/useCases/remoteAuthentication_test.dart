import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url);
  }
}

abstract class HttpClient {
  Future<void> request({required String url});
}

class HttpCLientSpy extends Mock implements HttpClient {}

void main() {
  test("Should call http client with correct url", () async {
    final httpClient = HttpCLientSpy();
    final url = faker.internet.httpsUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    await sut.auth();
    verify(httpClient.request(url: url));
  });
}
