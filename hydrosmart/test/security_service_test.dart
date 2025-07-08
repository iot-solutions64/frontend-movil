import 'package:flutter_test/flutter_test.dart';
import 'package:hydrosmart/features/security/data/remote/security_service.dart';
import 'package:hydrosmart/features/security/data/remote/user_dto.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'mocks/http_mock.mocks.dart';

void main() {
  late MockClient mockClient;
  late SecurityService service;

  setUp(() {
    mockClient = MockClient();
    service = SecurityService();
  });

  test('login devuelve Success cuando status 200', () async {
    final userJson = {
      "id": 1,
      "username": "admin",
      "token": "abc123"
    };
    when(mockClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response(jsonEncode(userJson), 200));

    final result = await service.login('admin', '12345');

    expect(result, isA<Success<UserDto>>());
    expect((result as Success<UserDto>).data!.username, 'admin');
  });

  test('login devuelve Error cuando status no es 200', () async {
    when(mockClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response('Unauthorized', 401));

    final result = await service.login('test', 'wrong');

    expect(result, isA<Error>());
    expect((result as Error).message, contains('401'));
  });

  test('login devuelve Error cuando hay excepción', () async {
    when(mockClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenThrow(Exception('Error: 401'));

    final result = await service.login('test', 'fail');

    expect(result, isA<Error>());
    expect((result as Error).message, contains('Error: 401'));
  });
}