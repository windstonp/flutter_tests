import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request(
      {required Uri url, required String method, Map? body}) async {
    await client.post(url);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group("Post Tests", () {
    test("Should call post with correct values", () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = Uri.parse(faker.internet.httpsUrl());

      await sut.request(url: url, method: "post");

      verify(client.post(url));
    });
  });
}
