import 'package:ecc_scription/point_processor.dart';

import 'point.dart';

class EllipticCurveElGamal {
  late final int prima;
  late final int a;
  late final int b;
  final PointProcessor processor;
  late final Point basePoint;
  late final List<Point> field;

  // required this.basePoint
  EllipticCurveElGamal({required this.processor}) {
    prima = processor.prima;
    a = processor.a;
    b = processor.b;

    field = processor.field;
    basePoint = processor.basePoint;
  }

  // TODO:: public key
  Point generatePublicKey(int privateKey) {
    return processor.multiply(privateKey, basePoint);
  }

  List<int> encrypt(List<int> bytes, Point publicKey) {
    List<int> result = [];
    List<Point> listPoint = [];

    for (int i = 0; i < bytes.length; i++) {
      listPoint.add(Point.byteToPoint(bytes[i], field));

      Map<Point, Point> encryptPoint =
          processor.encrypt(listPoint[i], publicKey, basePoint);
      final x = Point.pointToByte(encryptPoint.keys.first, field);
      final y = Point.pointToByte(encryptPoint.values.first, field);

      result.add(x);
      result.add(y);
    }

    return result;
  }

  List<int> decrypt(List<int> bytes, int privateKey) {
    List<int> result = [];
    var j = 0;
    for (var i = 0; i < bytes.length / 2; i++) {
      Map<Point, Point> mapPoint = {
        Point.byteToPoint(bytes[j], field):
            Point.byteToPoint(bytes[j + 1], field)
      };

      j += 2;

      final decryptPoint = processor.decrypt(mapPoint, privateKey, basePoint);
      result.add(Point.pointToByte(decryptPoint, field));
    }
    return result;
  }
}
