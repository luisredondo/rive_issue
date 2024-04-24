import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:rive/rive.dart';

extension _TextExtension on Artboard {
  TextValueRun? textRun(String name) => component<TextValueRun>(name);
}

ByteData _loadFile(String filename) {
  final file = File(
      './${Directory.current.path.endsWith('/test') ? '' : 'test/'}$filename');
  return ByteData.sublistView(file.readAsBytesSync());
}

void main() {
  late RiveFile riveFile;

  setUp(() {
    return Future(() async {
      final riveBytes = _loadFile('assets/text_run.riv');
      await RiveFile.initializeText();
      riveFile = RiveFile.import(riveBytes);
    });
  });

  test('Text run updating', () {
    final artboard = riveFile.mainArtboard.instance();
    final run1 = artboard.textRun('run1')!;
    final run2 = artboard.textRun('run2')!;
    expect(run1.text, "run1-value");
    expect(run2.text, "run2-value");
    run1.text = "new value 1";
    run2.text = "new value 2";
    expect(run1.text, "new value 1");
    expect(run2.text, "new value 2");
  });
}