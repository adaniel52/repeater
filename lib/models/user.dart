import 'dart:convert';

class User {
  int _page;

  User({
    required int page,
  }) : _page = page;

  int get page => _page;

  String toJson() => json.encode({
        'page': _page,
      });

  factory User.fromJson(String source) {
    final data = json.decode(source);
    return User(
      page: data['page'],
    );
  }
}

int getJuz(int page) {
  int temp = ((page - 1) / 20).ceil();
  return (temp < 1) ? 1 : (temp > 30 ? 30 : temp);
}
