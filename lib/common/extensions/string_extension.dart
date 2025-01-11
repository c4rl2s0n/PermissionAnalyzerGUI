
extension StringExtension on String{
  String get reversed => split('').reversed.join();


  String get filterWeirdCharacters {
    List<String> characters = ["\r"];
    String copy = this;
    for(String c in characters) {
      copy = copy.replaceAll(c, "");
    }
    return copy;
  }
}
extension NullableStringExtension on String?{
  bool get empty => this == null || this!.isEmpty;
  bool get notEmpty => this != null && this!.isNotEmpty;
}