void main() async {
  var x = await TT.xxx();

  var t = await TT.xxx();

  print(t);
  print(x);
}

class TT {
  static Future<int> xxx() async {
    await Future.delayed(Duration(seconds: 1));
    return 1;
  }
}
