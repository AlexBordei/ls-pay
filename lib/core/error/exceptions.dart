// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {
  String? message;

  ServerException({
    this.message,
  });
}

class CacheException implements Exception {}
