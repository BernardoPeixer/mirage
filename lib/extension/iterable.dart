/// Extension that adds utility methods to [Iterable].
///
/// This extension provides additional functionality to Dart's built-in
/// [Iterable] class, allowing for more versatile operations on collections.
///
/// Use cases include enhancing the handling of collections, providing
/// methods to streamline common tasks, and improving code readability.
extension IterableContextExtension on Iterable? {
  /// Extension that adds the [emptyValue] property to [Iterable].
  ///
  /// Returns `null` if the collection is empty or `null`, otherwise,
  /// returns the collection itself.
  ///
  /// ### Example
  /// ```dart
  /// Iterable? list1 = [];
  /// print(list1.emptyValue); // null
  ///
  /// Iterable? list2 = [1, 2, 3];
  /// print(list2.emptyValue); // [1, 2, 3]
  /// A property that returns `null` if the collection is empty or `null`,
  /// otherwise returns the collection itself.
  Iterable? get emptyValue {
    if ((this ?? []).isEmpty) {
      return null;
    }
    return this;
  }
}
