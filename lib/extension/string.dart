import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extension that adds utility methods to [String].
///
/// This extension provides additional functionality to Dart's built-in
/// [String] class, allowing for more versatile operations on strings.
///
/// Use cases include enhancing the handling of strings, providing
/// methods to streamline common tasks, and improving code readability.
extension StringContextExtension on String {
  /// Method for delete las word
  ///   List<String> c = x.split(""); ['a', 'a', 'a', 'b', 'c', 'd']
  ///   c.removeLast();  ['a', 'a', 'a', 'b', 'c']
  String removeLast() {
    final split = this.split('');
    split.removeLast();
    return split.join();
  }

  /// Method for get word in string
  String get firstWord {
    final list = split(' ');

    return list.first;
  }

  /// A property that returns `null` if the string is empty or `null`,
  /// otherwise returns the string itself.
  ///
  /// Returns `null` if the string is either `null` or empty (`''`).
  ///
  /// Example:
  /// ```dart
  /// String? str1 = '';
  /// print(str1.emptyValue); // null
  ///
  /// String? str2 = 'Hello, world!';
  /// print(str2.emptyValue); // 'Hello, world!'
  String? get nullableText {
    final string = trim();

    if (string.isEmpty) {
      return null;
    }
    return this;
  }

  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  /// Upper case the first letter
  String get upperCaseFirst {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
