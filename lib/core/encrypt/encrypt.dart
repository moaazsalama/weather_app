import 'package:encrypt/encrypt.dart';

class EncryptionService {
  final String _encryptionKey;
  late final Key key;
  late final IV iv;
  late Encrypter encrypter = Encrypter(
    AES(key, mode: AESMode.cbc, padding: 'PKCS7' /*, padding: 'PKCS7'*/),
  );
  EncryptionService(this._encryptionKey) {
    key = Key.fromUtf8(_encryptionKey);
    iv = IV.fromUtf8(_encryptionKey.substring(0, 16));
  }

  String encrypt(String data) {
    var result = encrypter.encrypt(data, iv: iv).base64;

    var datas = encrypter.decrypt(Encrypted.fromBase64(result), iv: iv);
    print('Entered Data $data');
    print('Encrypted Data $datas');
    return result;
  }

  String decrypt(String encryptedData) {
    final encryptedBytes = Encrypted.fromBase64(encryptedData);

    var data= encrypter.decrypt(encryptedBytes, iv: iv);
    print('Encrypted Data $data');
    return data;
  }
}
