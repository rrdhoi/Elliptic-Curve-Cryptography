import 'package:ecc_scription/point_processor.dart';

import 'point.dart';

class EllipticCurveDeffieHelman {
  late final int a;
  late final int b;
  late final int prima;
  final PointProcessor processor;

  EllipticCurveDeffieHelman({required this.processor}) {
    prima = processor.prima;
    a = processor.a;
    b = processor.b;
  }

  Point addNTimes(Point p1, Point p2, int n) {
    var i = n;
    var result = p1;
    while (i > 0) {
      result = processor.addTwoPoint(result, p2);
      i--;
    }
    return result;
  }

  Point calculatePublicKeys(Point basePoint, int privateKey) {
    return addNTimes(basePoint, basePoint, privateKey - 1);
  }

  Point calculateSharedKey(Point publicKey, Point basePoint, int privateKey) {
    return addNTimes(publicKey, basePoint, privateKey);
  }

  @override
  toString() {
    return "a: $a, b: $b, p: $prima";
  }
}
