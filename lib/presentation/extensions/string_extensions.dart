extension StringExtensions on String {
  removeCaractersAndNumbers() => replaceAll(RegExp('[^0-9]'), "");

  String asPadLeft([int width = 2]) =>
      padLeft(width, '0');

  toDateFormat() {
    final date = DateTime.parse(this);
    final d = date.day.toString().asPadLeft();
    final m = date.month.toString().asPadLeft();
    final y = date.year.toString().asPadLeft();
    return '$d/$m/$y';
  }
}