import '../../presentation/util/util/date_time_format.dart';

/// UserInfo represents the information of a user who owns festival cards.
class UserInfo {
  /// Constructor default
  UserInfo({
    required this.id,
    required this.username,
    required this.walletAddress,
    required this.statusCode,
    this.createdAt,
    this.modifiedAt,
  });

  /// ID is the unique identifier of the user
  final int id;

  /// Username is the user's name or handle
  final String username;

  /// WalletAddress is the blockchain wallet address of the user
  final String walletAddress;

  /// StatusCode indicates the current status of the user (e.g., active, banned)
  final int statusCode;

  /// CreatedAt is the timestamp when the user was created
  final DateTime? createdAt;

  /// ModifiedAt is the timestamp when the user was last modified
  final DateTime? modifiedAt;

  /// Creates a [UserInfo] instance from a JSON map.
  factory UserInfo.fromJson({required Map<String, dynamic> json}) {
    final createdAt = tryParseDate(
      formattedFullDateTime,
      json['created_at'] ?? '',
    );

    final modifiedAt = tryParseDate(
      formattedFullDateTime,
      json['modified_at'] ?? '',
    );

    return UserInfo(
      id: json['id'],
      username: json['username'],
      walletAddress: json['wallet_address'],
      statusCode: json['status_code'],
      createdAt: createdAt,
      modifiedAt: modifiedAt,
    );
  }
}
