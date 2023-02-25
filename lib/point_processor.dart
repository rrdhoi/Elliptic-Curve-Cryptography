import 'point.dart';

class PointProcessor {
  int prima;
  int a;
  int b;
  late final Point basePoint;
  late List<Point> field = [];
  final List<int> poweredByTwo = [];

  PointProcessor({required this.a, required this.b, required this.prima}) {
    field = generateGaloisField();
    basePoint = field[0];
  }

  Point doublePoint(Point point) {
    if (point.y == 0) return point;
    final top = mod(3 * point.x * point.x + a);
    final bottom = mod(2 * point.y);
    final m = mod(top * getInverse(bottom));
    final xr = mod(m * m - 2 * point.x);
    final yr = mod(m * (point.x - xr) - point.y);
    return Point(x: xr, y: yr);
  }

  // TODO:: pelajari
  Point multiply(int k, Point basePoint) {
    var result = Point();
    var base = Point(x: basePoint.x, y: basePoint.y);
    var binary = k.toRadixString(2);
    for (int i = binary.length - 1; i >= 0; i--) {
      if (binary[i] == '1') {
        if (i == binary.length - 1) {
          result = base;
        } else {
          result = addTwoPoint(result, base);
        }
      }
      base = doublePoint(base);
    }
    return result;
  }

  Point addTwoPoint(Point p1, Point p2) {
    if (p1 == p2) {
      return doublePoint(p1);
    } else if (p1.x == p2.x) {
      return Point(x: 30, y: 2); //spasi
    } else {
      return distinctAdd(p1, p2);
    }
  }

  Point distinctAdd(Point p1, Point p2) {
    final top = mod(p1.y - p2.y);
    final bottom = mod(p1.x - p2.x);
    final m = mod(top * getInverse(bottom));
    final xr = mod(m * m - p1.x - p2.x);
    final yr = mod(m * (p1.x - xr) - p1.y);
    return Point(x: xr, y: yr);
  }

  int mod(int num) {
    return num % prima;
  }

  int getInverse(int num) {
    for (int i = 1; i < prima; i++) {
      if (num * i % prima == 1) {
        return i;
      }
    }

    return num;
  }

  Point minus(Point p1, Point p2) {
    var newPoint = Point();
    newPoint.x = p2.x;
    newPoint.y = -p2.y;
    return addTwoPoint(p1, newPoint);
  }

  /// * Kurva Eliptik Galois Field - GF(P)
  ///   menghasilkan semua titik P(x, y)
  ///   (baca Kurva Eliptik Galois Field)
  List<Point> generateGaloisField() {
    List<Point> points = [];
    List<int> temp = [];

    bilanganPangkat2();
    for (int i = 0; i < prima; i++) {
      temp = xIntoEllipticCurve(i);
      for (int j = 0; j < temp.length; j++) {
        points.add(Point(x: i, y: temp[j]));
      }
    }
    return points;
  }

  /// * Membuat bilangan dipangkat 2 (baca Galois Field)
  ///   kemudian dimodulo di fungsi [xIntoEllipticCurve]
  void bilanganPangkat2() {
    for (int i = 0; i < prima; i++) {
      poweredByTwo.add(i * i);
    }
  }

  /// * 1. Sulihkan x kedalam persamaan kurva eliptik
  ///   2. nilai bilangan yang dipangkat 2 di mod,
  ///      hasilnya sama dengan y
  ///   (baca Kurva Eliptik Galois Field)
  List<int> xIntoEllipticCurve(int x) {
    List<int> result = [];
    var y = (x * x * x + a * x + b).toDouble();
    y %= prima;

    for (int i = 0; i < poweredByTwo.length; i++) {
      if ((poweredByTwo[i] % prima).toDouble() == y) result.add(i);
    }
    return result;
  }

  /// * enkripsi
  ///   @param [pm] plaintext
  ///   @param [pub] public key
  ///   @param [base] base point
  Map<Point, Point> encrypt(Point pm, Point pub, Point basePoint) {
    // TODO:: private key
    int k = 5;
    Point px = multiply(k, basePoint);
    Point py = addTwoPoint(pm, multiply(k, pub));
    Map<Point, Point> pc = {px: py};
    return pc;
  }

  Point decrypt(Map<Point, Point> pc, int privateKey, Point basePoint) {
    Point bKB = multiply(privateKey, pc.keys.first);
    Point pm = minus(pc.values.first, bKB);
    return pm;
  }
}

void main() {
  var prima = 239;
  // TODO:: value x^3 + ax + b
  int a = 8;

  var pp = PointProcessor(prima: prima, a: a, b: 1);
  var p1 = Point(x: 2, y: 4);
  var p2 = Point(x: 5, y: 9);
  var basePoint = Point(x: 2, y: 53);
  var publicKey = Point(x: 64, y: 286);
  var plainText = Point(x: 111, y: 8);
  var privateKey = 3;

  var pc = pp.encrypt(plainText, publicKey, basePoint);
  print("CipherText :: $pc");

  var pm2 = pp.decrypt(pc, privateKey, basePoint);
  print("Decrypt PlainText :: $pm2");
}
