import 'package:flutter_image_compress/flutter_image_compress.dart';

// Image Comprepressor
Future<XFile?> compressAndGetFile(XFile file, String targetPath) async {
  print("compressAndGetFile");
  final result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 40,
    minWidth: 500,
    minHeight: 500,
  );

  print(file.readAsBytes());
  // print(result?.lengthSync());

  return result;
}
