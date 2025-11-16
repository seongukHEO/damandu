import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:exif/exif.dart';

class ImageProcessor {
  /// 이미지 압축 및 EXIF 방향 수정 메서드
  static Future<File?> compressAndFixOrientation({
    required File imageFile,
    int targetWidth = 1024,
    int quality = 85,
  }) async {
    try {
      // 이미지 파일을 바이트로 읽기
      final bytes = await imageFile.readAsBytes();

      // 이미지 디코딩
      img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
      if (image == null) {
        return null; // 압축할 이미지가 없으면 null 반환
      }

      // EXIF 데이터 읽기
      final exifData = await readExifFromBytes(bytes);
      int orientation = 1; // 기본 방향

      if (exifData != null && exifData.containsKey('Image Orientation')) {
        final orientationValue = exifData['Image Orientation'];
        if (orientationValue is IfdTag) {
          final values = orientationValue.values;
          if (values != null && values.isNotEmpty) {
            orientation = values.first as int; // 방향 값 추출
          }
        }
      }

      // 회전 정보에 따라 이미지 회전
      image = _fixOrientation(image, orientation);

      // 이미지 크기 조정
      img.Image resizedImage = img.copyResize(image, width: targetWidth);

      // 압축된 이미지 바이트로 변환
      final compressedBytes = img.encodeJpg(resizedImage, quality: quality);

      // 압축된 이미지를 파일로 저장
      final compressedImage = File('${imageFile.path}_compressed.jpg');
      await compressedImage.writeAsBytes(compressedBytes);

      return compressedImage;
    } catch (e) {
      print('이미지 처리 오류: $e');
      return null;
    }
  }

  /// 회전 정보에 따라 이미지를 회전하는 내부 메서드
  static img.Image _fixOrientation(img.Image image, int orientation) {
    switch (orientation) {
      case 6:
        return img.copyRotate(image, 90); // 90도 회전
      case 3:
        return img.copyRotate(image, 180); // 180도 회전
      case 8:
        return img.copyRotate(image, -90); // -90도 회전
      default:
        return image; // 회전 없음
    }
  }
}
