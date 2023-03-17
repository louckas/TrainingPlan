import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> getLocalFile(String file) async {
  final directory = await getApplicationDocumentsDirectory();

  return File("${directory.path}/$file");
}
