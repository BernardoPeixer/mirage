import 'dart:ui';

import 'package:mirage/default/colors.dart';
import 'package:mirage/domain/entities/entity_user.dart';
import 'package:mirage/generated/l10n.dart';

import '../../presentation/util/util/date_time_format.dart';
import 'entity_crypto.dart';

/// FestivalCards represents a festival card owned by a user.
/// It includes references to the user, crypto information, pricing, and
/// timestamps.
class FestivalCard {
  /// Default constructor
  FestivalCard({
    required this.id,
    required this.userInfo,
    required this.balance,
    required this.cryptoType,
    required this.cryptoPrice,
    this.soldAt,
    required this.statusCode,
    this.createdAt,
    this.modifiedAt,
  });

  /// ID is the unique identifier of the festival card
  final int id;

  /// UserInfo contains the information of the card owner
  final UserInfo userInfo;

  /// Balance is the current balance on the card, using double for
  /// precise monetary values
  final String balance;

  /// CryptoType represents the type of cryptocurrency associated with the card
  final CryptoType cryptoType;

  /// CryptoPrice is the price of the cryptocurrency at the time of card creation or sale
  final String cryptoPrice;

  /// SoldAt is the timestamp when the card was sold (nullable)
  final DateTime? soldAt;

  /// StatusCode represents the current status of the card (e.g., active, sold)
  final int statusCode;

  /// CreatedAt is the timestamp when the card was created
  final DateTime? createdAt;

  /// ModifiedAt is the timestamp when the card was last modified
  final DateTime? modifiedAt;

  /// Getter to formatted crypto price
  String get cryptoPriceFormatted => '$cryptoPrice ${cryptoType.symbol}';

  /// Getter to card status
  String get cardStatus =>
      statusCode == 0 ? S.current.available : S.current.unavailable;

  Color get cardStatusColor {
    switch (statusCode) {
      case 0:
        return AppColors.availableCardColor;
      case 2:
        return AppColors.unavailableCardColor;
      default:
        return AppColors.unavailableCardColor;
    }
  }

  Color get cardTextStatusColor {
    switch (statusCode) {
      case 0:
        return AppColors.softOrange;
      case 2:
        return AppColors.unavailableTextColor;
      default:
        return AppColors.unavailableTextColor;
    }
  }

  factory FestivalCard.fromJson({required Map<String, dynamic> json}) {
    final createdAt = tryParseDate(formattedFullDateTime, json['created_at']);
    final modifiedAt = tryParseDate(formattedFullDateTime, json['modified_at']);

    final soldAt = tryParseDate(formattedFullDateTime, json['sold_at'] ?? '');

    return FestivalCard(
      id: json['id'],
      userInfo: UserInfo.fromJson(json: json['user']),
      balance: json['balance'],
      cryptoType: CryptoType.fromJson(json: json['crypto_type']),
      cryptoPrice: json['crypto_price'],
      soldAt: soldAt,
      statusCode: json['status_code'],
      createdAt: createdAt,
      modifiedAt: modifiedAt,
    );
  }
}
