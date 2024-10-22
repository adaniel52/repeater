class Juz {
  final List<Rubu> _rubu;
  String? _fluency;

  Juz({
    List<Rubu>? rubu,
    String? fluency,
  })  : _rubu = rubu ??
            [
              Rubu(number: 1),
              Rubu(number: 2),
              Rubu(number: 3),
              Rubu(number: 4),
              Rubu(number: 5),
              Rubu(number: 6),
              Rubu(number: 7),
              Rubu(number: 8),
            ],
        _fluency = fluency;

  List<Rubu> get rubu => _rubu;
  String get fluency => _fluency ?? 'None';

  set fluency(String value) {
    _fluency = value;
  }

  Juz copyWith({
    List<Rubu>? rubu,
    String? fluency,
  }) {
    return Juz(
      rubu: rubu ?? this.rubu,
      fluency: fluency ?? this.fluency,
    );
  }
}

class Rubu {
  final int _number;
  DateTime? _lastReviewed;

  Rubu({
    required int number,
    DateTime? lastReviewed,
  })  : _number = number,
        _lastReviewed = lastReviewed;

  int get number => _number;
  // DateTime? get lastReviewed => _lastReviewed;

  // set lastReviewed(DateTime? value) {
  //   _lastReviewed = value;
  // }
}
