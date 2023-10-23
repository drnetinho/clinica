import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class StorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String?> imgFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      return await uploadImage(pickedFile);
    }
    return null;
  }

  static Future<String?> uploadImage(XFile xfile) async {
    Reference reference = _storage.ref().child('images/${Path.basename(xfile.path)}');

    final data = await xfile.readAsBytes();
    UploadTask uploadTask = reference.putData(
      data,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<void> deleteImage(String imageFileUrl) async {
    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl)).replaceAll(RegExp(r'(\?alt).*'), '');

    final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
  }
}
