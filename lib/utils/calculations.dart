int getJuz(int page) {
  int temp = ((page - 1) / 20).ceil();
  return (temp < 1) ? 1 : (temp > 30 ? 30 : temp);
}
