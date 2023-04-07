import 'package:fordev/domain/entities/entities.dart';

class RemoteAccountEntity {
  final String accessToken;

  RemoteAccountEntity(this.accessToken);

  factory RemoteAccountEntity.fromJson(Map json) =>
      RemoteAccountEntity(json["accessToken"]);

  AccountEntity toEntity() => AccountEntity(accessToken);
}
