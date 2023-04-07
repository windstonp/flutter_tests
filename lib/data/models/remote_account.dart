import '../../data/http/http.dart';
import '../../domain/entities/entities.dart';

class RemoteAccountEntity {
  final String accessToken;

  RemoteAccountEntity(this.accessToken);

  factory RemoteAccountEntity.fromJson(Map json) {
    if (!json.containsKey("accessToken")) {
      throw HttpError.invalidData;
    }
    return RemoteAccountEntity(json["accessToken"]);
  }
  AccountEntity toEntity() => AccountEntity(accessToken);
}
