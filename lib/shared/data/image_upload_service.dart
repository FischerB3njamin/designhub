import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  static Future<String> uploadProfileImage(File file) async {
    File? compressedFile;

    try {
      compressedFile = await testCompressAndGetFile(file);

      if (compressedFile == null) {
        throw Exception('Komprimierung fehlgeschlagen');
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}');

      await storageRef.putFile(compressedFile);
      final downloadUrl = await storageRef.getDownloadURL();

      if (await compressedFile.exists()) {
        await compressedFile.delete();
      }

      return downloadUrl;
    } catch (e) {
      return '';
    }
  }

  static Future<File?> testCompressAndGetFile(File file) async {
    final tempDir = Directory.systemTemp;
    final targetPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.webp';

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 100,
      format: CompressFormat.webp,
    );

    if (result != null) {
      final compressedFile = File(result.path);

      return compressedFile;
    }

    return null;
  }

  static String addOneBeforeExtension(String path) {
    final extensionIndex = path.lastIndexOf('.');
    if (extensionIndex == -1) return path;

    final name = path.substring(0, extensionIndex);
    final extension = path.substring(extensionIndex);
    return '${name}1$extension';
  }

  static Future<String?> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        return picked.path;
      }
    } catch (e) {
      if (e is PlatformException) {
        if (context.mounted) {
          showCustomDialog(Platform.isIOS, context);
        }
      }
    }
    return null;
  }

  static void showCustomDialog(bool isIOS, BuildContext context) {
    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => alertDialog(context),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => alertDialog(context),
      );
    }
  }

  static Widget alertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Fehlende Berechtigungen'),
      content: Text(
          'Aktuell hast du nicht alle berechtigungen gegebn, die diese App braucht.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            AppSettings.openAppSettings(type: AppSettingsType.location);
          },
          child: Text('Einstellungen öffnen'),
        ),
      ],
    );
  }
}
