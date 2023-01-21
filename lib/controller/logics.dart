import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class Logics {
  Future<String> createPdfPath(String pdfFile) async {
    var decodedPdf = base64Decode(pdfFile);
    final output = (await getApplicationDocumentsDirectory()).path;
    final file = File("${output}" + DateTime.now().millisecondsSinceEpoch.toString() + '.pdf');
    await file.writeAsBytes(decodedPdf.buffer.asUint8List());

    await OpenFilex.open(file.path);
    return file.path;
  }

  convertBaseImage(List<String> extensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );
    if (result != null) {
      PlatformFile? files = result.files.first;
      final bytes = await File(files.path ?? "").readAsBytes();
      String img64 = base64Encode(bytes);
      return img64;
    }
  }
}
