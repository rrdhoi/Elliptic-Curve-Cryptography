import 'dart:typed_data';

class Point {
  int x = 0;
  int y = 0;

  Point({this.x = 0, this.y = 0});

  @override
  String toString() {
    return "$x $y";
  }

  bool isEqual(Point point) => (x == point.x && y == point.y);

  /// * Konversi Point ke byte
  ///   Mengambil indeks(k) dari [field] lalu ubah ke byte
  static int pointToByte(Point point, List<Point> field) {
    List<int> value = [];
    for (var i = 0; i < field.length; i++) {
      if (field[i].isEqual(point)) {
        value.add(i);
        break;
      }
    }
    return Uint8List.fromList(value).first;
  }

  /// * Konversi Byte ke Point
  ///   mengembalikan [Point] yang ke index(k)
  static Point byteToPoint(int byte, List<Point> field) {
    int index = byte & 0xFF;
    return Point(x: field[index].x, y: field[index].y);
  }
}
