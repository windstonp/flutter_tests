import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request(
      {required Uri url, required String method, Map? body}) async {
    final headers = {
      "content-type": "application/json",
      "accept": "application/json"
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    await client.post(url, headers: headers, body: jsonBody);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late Uri url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = Uri.parse(faker.internet.httpsUrl());
  });

  group("Post Tests", () {
    test("Should call post with correct values", () async {
      await sut
          .request(url: url, method: "post", body: {"any_key": "any_value"});

      verify(client.post(url,
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          },
          body: jsonEncode({"any_key": "any_value"})));
    });

    test("Should call post without body", () async {
      await sut.request(url: url, method: "post");

      verify(client.post(url, headers: anyNamed("headers")));
    });
  });
}
