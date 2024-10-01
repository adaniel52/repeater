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
