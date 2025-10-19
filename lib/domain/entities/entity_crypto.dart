import 'package:mirage/default/app_assets.dart';
import 'package:mirage/presentation/util/util/date_time_format.dart';

/// CryptoType represents a cryptocurrency type that can be associated with a
/// festival card.
class CryptoType {
  /// Constructor default
  CryptoType({
    required this.id,
    required this.symbol,
    required this.name,
    required this.statusCode,
    this.createdAt,
    this.modifiedAt,
  });

  /// ID is the unique identifier of the cryptocurrency
  final int id;

  /// Symbol is the short symbol of the cryptocurrency (e.g., BTC, ETH)
  final String symbol;

  /// Name is the full name of the cryptocurrency
  final String name;

  /// StatusCode indicates the current status of the crypto (e.g., active, inactive)
  final int statusCode;

  /// CreatedAt is the timestamp when the crypto type was created
  final DateTime? createdAt;

  /// ModifiedAt is the timestamp when the crypto type was last modified
  final DateTime? modifiedAt;

  String cryptoImage() {
    switch(symbol) {
      case 'ETH':
        return AppAssets.ethereumPath;
      case 'BTC':
        return AppAssets.bitcoinPath;
      case 'PYUSD':
        return AppAssets.payPalUsdPath;
      default:
        return AppAssets.ethereumPath;
    }
  }

  /// Creates a [CryptoType] instance from a JSON map.
  factory CryptoType.fromJson({required Map<String, dynamic> json}) {
    final createdAt = tryParseDate(formattedFullDateTime, json['created_at']);
    final modifiedAt = tryParseDate(formattedFullDateTime, json['modified_at']);

    return CryptoType(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      statusCode: json['status_code'],
      createdAt: createdAt,
      modifiedAt: modifiedAt,
    );
  }
}
