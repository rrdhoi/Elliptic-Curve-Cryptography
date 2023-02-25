import 'dart:convert';

import 'package:ecc_scription/new/ec_point.dart' as ec_point;

import 'new/dasar_perhitungan_ecc.dart';
import 'new/ecc_big_int/ecc.dart';
import 'new/ecc_big_int/standard_curve.dart';

void main() {
  /*final stopwatch = Stopwatch();
  final textKey = "19 Juni 20011";
  stopwatch.start();
  final byteKey = utf8.encode(textKey);
  final data = byteKey.join().substring(0, 16);
  int privateKey = int.parse(data);
  // int privateKey = byteKey.sum;

  print("Private Key: $privateKey");
  final ec = EllipticCurve(a: -1, b: 188, prima: 65537);
  final publicKey = ec.multiplyPoint(Point(x: 1, y: 6), privateKey);
  print("Public Key: $publicKey");
  print("Execution Time (Public Key) :: ${stopwatch.elapsed}");
  ellipticCurveElGamal(privateKey);
  stopwatch.stop();*/
  // programLamaElGamal();
  // ellipticCurveElGamal();

  // testECC();
  mengubahPesanMenjadiTitik();
  // testRSA();
  // testAES();
}

/*void testECC() {
  final prima = BigInt.parse(
      "6277101735386680763835789423207666416102355444459739541047");
  final a = BigInt.from(0);
  final b = BigInt.from(3);
  final basePoint = ECPoint(
      BigInt.parse(
          "5377521262291226325198505011805525673063229037935769709693"),
      BigInt.parse(
          "3805108391982600717572440947423858335415441070543209377693"));
  final curve_SECP_192_K1 = baru.EllipticCurve(a: a, b: b, prima: prima);
   for (int i = 0; i < 25; i++) {
    print("$i * G = (${curve_SECP_192_K1.multiplyPoint(basePoint, i)})");
  }
}*/

String customFormat(Duration data) {
  final dataString = data.toString();
  final milliseconds = dataString.substring(dataString.length - 8);
  final convertToComa = milliseconds.replaceAll('.', ',');
  return convertToComa;
}

void testECC() {
  final ec = StandardCurve.secp521r1;
  final textKey192Bit = "r.ridoi702";

  final ec_point.ECPoint basePoint = StandardCurve.secp521r1BasePoint;

  final byteKey = utf8.encode(textKey192Bit);
  final concreteKey = byteKey.join();
  // BigInt privateKey = BigInt.parse(
  //     concreteKey.length <= 58 ? concreteKey : concreteKey.substring(0, 58));
  // tanpa memperhatikan panjang key, jadi keynya setiap pengujian sama
  BigInt privateKey = BigInt.parse(
      concreteKey.length <= 157 ? concreteKey : concreteKey.substring(0, 157));
  /* final publicKey = ec.multiplyPoint(
      basePoint,
      BigInt.parse(
          "4225655318977962031264230130242180748818603147467615868902"));
  print("Public Key : $publicKey");*/
  final stopwatch = Stopwatch();
  final ecc =
      ECC(ellipticCurve: ec, privateKey: privateKey, basePoint: basePoint);

  // variasi yang diketahui berbeda : (o, i)
  final asli = 'Lorem ipsu';
  final encryptedMessages = ecc.encrypt('a');
  final listDigits = <BigInt>[];
  for (var point in encryptedMessages) {
    listDigits.add(point.pointKey.x);
    listDigits.add(point.pointKey.y);
    listDigits.add(point.pointMessage.x);
    listDigits.add(point.pointMessage.y);
  }
  final ciphertextDigits = listDigits.join();
  print('${ciphertextDigits.length}');

/*  for (int i = 0; i < listSample1000.length; i++) {
    final encryptedMessages = ecc.encrypt(listSample1000[i]);
    final listDigits = <BigInt>[];
    for (var point in encryptedMessages) {
      listDigits.add(point.pointKey.x);
      listDigits.add(point.pointKey.y);
      listDigits.add(point.pointMessage.x);
      listDigits.add(point.pointMessage.y);
    }
    final ciphertextDigits = listDigits.join();
    print('${ciphertextDigits.length}');
  }*/

  /*final data = listSample1000[5];
  print("panjang karakter = ${data.length}");
  for (int i = 0; i < 20; i++) {
    stopwatch.start();
    final encryptedMessages = ecc.encrypt(data);
    final encryptTime = stopwatch.elapsed;
    ecc.decrypt(encryptedMessages);
    print("${customFormat(encryptTime)} ${customFormat(stopwatch.elapsed)}");
    stopwatch.reset();
  }*/
}

/*void testAES() {
  final plainText = "1234567890";
  final textKey192Bit = "Lorem ipsum dolor sit am";
  final stopwatch = Stopwatch();
  stopwatch.start();
  final encrypt = Encryptor.encrypt(textKey192Bit, plainText);
  print("AES Encrypt Time:: ${stopwatch.elapsed}");
  Encryptor.decrypt(textKey192Bit, encrypt);
  print("AES Decrypt Time:: ${stopwatch.elapsed}");
  stopwatch.stop();
}*/

/*void testRSA() {
  // final plainText = "a";

  // final textKey192Bit = "r.ridoi702";
*/ /*  final keyToBit = textKey192Bit.codeUnits
      .map((x) => x.toRadixString(2).padLeft(8, '0'))
      .join();*/ /*
  final rsaKeyPair = RSAKeypair.fromRandom();
  final stopwatch = Stopwatch();
  for (int i = 0; i < listSample200.length; i++) {
    final data = listSample200[i];
    stopwatch.start();
    final encrypt = rsaKeyPair.publicKey.encrypt(data);
    final rsaEncryptTime = stopwatch.elapsed;
    rsaKeyPair.privateKey.decrypt(encrypt);
    print("${customFormat(rsaEncryptTime)} ${customFormat(stopwatch.elapsed)}");
    stopwatch.stop();
  }
}*/

/*void testECClama() {
  final ec = EllipticCurve(a: -1, b: 188, prima: 65537);

  final textKey = "r.ridoi702";
  final byteKey = utf8.encode(textKey);
  final concreteKey = byteKey.join().substring(0, 16);
  int privateKey = int.parse(concreteKey);
  // int privateKey = byteKey.sum;

  final publicKey = ec.multiplyPoint(Point(x: 1, y: 6), privateKey);
  print("LAMA ECC Public Key: $publicKey");

  // Encrypt
  final elGamal = ElGamalECC(ellipticCurve: ec, privateKey: privateKey);
  final encryptedMessages = elGamal.encrypt("Hello World", publicKey);
  print("LAMA ECC Ciphertext: $encryptedMessages");
  final m = elGamal.decrypt(encryptedMessages, privateKey);
  print("LAMA ECC Decrypted: $m");
  print('\n');
}*/

/*void ellipticCurveElGamal() {
  final ec = EllipticCurve(a: -1, b: 188, prima: 65537);

  final stopwatch = Stopwatch();
  final textKey = "r.ridoi702";
  stopwatch.start();
  final byteKey = utf8.encode(textKey);
  final concreteKey = byteKey.join().substring(0, 16);
  int privateKey = int.parse(concreteKey);
  // int privateKey = byteKey.sum;

  print("Private Key: $privateKey");
  final publicKey = ec.multiplyPoint(Point(x: 1, y: 6), privateKey);
  print("Public Key: $publicKey");
  print("Execution Time (Public Key) :: ${stopwatch.elapsed}");

  print("----------------------------------------------------");
  // Encrypt
  final elGamal = ElGamalECC(ellipticCurve: ec, privateKey: privateKey);
  final message =
      "Panjang total jalan yang akan dipasang gardu tersebut adalah 1.5 meter dari batas timur sampai barat karapitan.Setiap gardu memiliki harga 3.5 juta rupiah belum termasuk biaya pemasangan";
  print("Message: $message");
  print("----------------------------------------------------");
  final encryptedMessages = elGamal.encrypt(message, publicKey);
  print("Execution Time (Encrypt) :: ${stopwatch.elapsed}");
  print("PublicKey: ${elGamal.publicKey}");
  print("Ciphertext: $encryptedMessages");
  print("----------------------------------------------------");
  final m = elGamal.decrypt(encryptedMessages, privateKey);
  print("Execution Time (Decrypt) :: ${stopwatch.elapsed}");
  print("Decrypted: $m");
  stopwatch.stop();
}*/

/*
pertukaranKunci() {
  final ec = EllipticCurve(a: -1, b: 188, prima: 65537);
  final textKey = "19 Juni 2001";
  final bTextKey = "29 Maret 2002";
  final byteKey = utf8.encode(textKey);
  final bByteKey = utf8.encode(bTextKey);
  int privateKey = byteKey.sum;
  int bPrivateKey = bByteKey.sum;
  print("Byte Key: ${byteKey.sum}");
  print("Key: $textKey");
  print("Alice privateKey: $privateKey");
  print("Bob privateKey: $bPrivateKey");
  print("----------------------------------------------------");
  // Encrypt
  final elGamal = ElGamalECC(ellipticCurve: ec, privateKey: privateKey);
  final bobSecretKey = ec.multiplyPoint(elGamal.publicKey, bPrivateKey);
  print("Secret Key Bob :: $bobSecretKey");
  final bobElGamal = ElGamalECC(ellipticCurve: ec, privateKey: bPrivateKey);
  final aliceSecretKey = ec.multiplyPoint(bobElGamal.publicKey, privateKey);
  print("Secret Key Alice :: $aliceSecretKey");
  return aliceSecretKey;
}
*/

/*
void programLamaElGamal() {
  // El - Gamal
  final processor = PointProcessor(prima: 17, a: 0, b: 7);
  for (int i = 0; i < 25; i++) {
    print("$i * G = (${processor.multiply(i, Point(x: 15, y: 13))})");
  }
  // final plainText = Point.byteToPoint(52, processor.field);

  */
/*var text = "Muhammad Ridhoi";
  // convert string to byte (0-255 ascii code)
  final elGamal = EllipticCurveElGamal(processor: processor);
  print("Base ${elGamal.basePoint}");
  var bytes = utf8.encode(text);
  print("Text awal : $text");
  print("Bytes awal : $bytes");

  final publicKey = elGamal.generatePublicKey(privateKey);

  var result = elGamal.encrypt(bytes, publicKey);
  print("byte encrypt: $result");

  result = elGamal.decrypt(result, privateKey);
  print("byte decrypt : $result");

  print("Text hasil : ${utf8.decode(result)}");*/ /*

}
*/
