import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import 'package:fordev/data/http/http.dart';
import 'package:fordev/infra/http/http.dart';

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

  group("Shared tests", () {
    test("Should throw server error if invalid method is provided", () async {
      final future = sut.request(url: url, method: "invalid method");

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group("Post Tests", () {
    PostExpectation mockRequest() => when(client.post(Uri.parse(url),
        headers: anyNamed("headers"), body: anyNamed("body")));
    void mockResponse(int status, {String body = '{"any_key": "any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, status));
    }

    void mockError() => mockRequest().thenThrow(Exception());

    setUp(() {
      mockResponse(200);
    });

    test("Should call post with correct values", () async {
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
      await sut.request(url: url, method: "post");

      verify(client.post(Uri.parse(url), headers: anyNamed("headers")));
    });

    test("Should return data if request with status 200", () async {
      final response = await sut.request(url: url, method: "post");

      expect(response, {"any_key": "any_value"});
    });

    test("Should return null if request with status 200 with no data",
        () async {
      mockResponse(200, body: '');
      final response = await sut.request(url: url, method: "post");

      expect(response, null);
    });

    test("Should return null if request with status 204 with no data",
        () async {
      mockResponse(204, body: '');
      final response = await sut.request(url: url, method: "post");

      expect(response, null);
    });

    test("Should return null if request with status 204 with data", () async {
      mockResponse(204);
      final response = await sut.request(url: url, method: "post");

      expect(response, null);
    });
    test("Should return badRequestError if request with status 400", () async {
      mockResponse(400);
      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.badRequest));
    });

    test(
        "Should return badRequestError if request with status 400 without body",
        () async {
      mockResponse(400, body: '');
      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.badRequest));
    });
    test("Should return unauthorizedError if request with status 401",
        () async {
      mockResponse(401);
      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.unauthorized));
    });

    test("Should return notFoundError if request with status 403", () async {
      mockResponse(403);
      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.forbiden));
    });

    test("Should return notFoundError if request with status 404", () async {
      mockResponse(404);
      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.notFound));
    });
    test("Should return serverError if request with status 500", () async {
      mockResponse(500);
      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.serverError));
    });

    test("Should return serverError if request throws error", () async {
      mockError();
      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.serverError));
    });
    test(
        "Should return serverError if request with diferent status from the requests above",
        () async {
      mockResponse(301);
      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.serverError));
    });
  });
}
