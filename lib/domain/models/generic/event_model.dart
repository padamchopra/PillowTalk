class Event<T> {
  bool _handled = false;
  final T _data;
  Event(T data): _data = data;

  T? get data {
    if (!_handled) {
      _handled = true;
      return _data;
    }
    return null;
  }
}
