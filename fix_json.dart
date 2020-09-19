import 'dart:io';

void main() async {
  File jsonFile = new File('want_to_fix.json');
  File fixed = new File('fixed.json');

  await jsonFile.readAsString().then((data) {
    String res = data
        .replaceAll("  ", "")
        .replaceAll("   ", "")
        .replaceAll("    ", "")
        .replaceAll("     ", "")
        .replaceAll("      ", "")
        .replaceAll("       ", "")
        .replaceAll("        ", "")
        .replaceAll("         ", "")
        .replaceAll("          ", "")
        .replaceAll('\n', "\b ");
    fixed.writeAsString(
      res,
      mode: FileMode.append,
    );
  });
}
