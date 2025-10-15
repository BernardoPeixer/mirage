/// Get defaults that use of [int]
extension IntContextExtension on int {

  /// Method for validate if text is empty
  int? get nullable {

    if (this == 0) {
      return null;
    }
    return this;
  }
}