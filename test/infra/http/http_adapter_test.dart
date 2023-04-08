import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/data/http/http.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map> request(
      {required String url, required String method, Map? body}) async {
    final headers = {
      "content-type": "application/json",
      "accept": "application/json"
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response =
        await client.post(Uri.parse(url), headers: headers, body: jsonBody);

    return jsonDecode(response.body);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpsUrl();
  });

  group("Post Tests", () {
    test("Should call post with correct values", () async {
      when(client.post(Uri.parse(url),
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer((_) async => Response('{"any_key": "any_value"}', 200));
      await sut
          .request(url: url, method: "post", body: {"any_key": "any_value"});

      verify(client.post(Uri.parse(url),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          },
          body: jsonEncode({"any_key": "any_value"})));
    });

    test("Should call post without body", () async {
      when(client.post(Uri.parse(url), headers: anyNamed("headers")))
          .thenAnswer((_) async => Response('{"any_key": "any_value"}', 200));
      await sut.request(url: url, method: "post");

      verify(client.post(Uri.parse(url), headers: anyNamed("headers")));
    });

    test("Should return data if request with status 200", () async {
      when(client.post(Uri.parse(url), headers: anyNamed("headers")))
          .thenAnswer((_) async => Response('{"any_key": "any_value"}', 200));
      final response = await sut.request(url: url, method: "post");

      expect(response, {"any_key": "any_value"});
    });
  });
}
