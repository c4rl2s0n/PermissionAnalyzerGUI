
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