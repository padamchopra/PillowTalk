import 'dart:async';

import 'package:pillowtalk/domain/models/generic/error_message_model.dart';

abstract class UseCase<T> {
  final _controller = StreamController<T>();
  Stream<T> get stream => _controller.stream;

  void add(T obj) {
    _controller.sink.add(obj);
  }

  void addError(ErrorMessageModel error) {
    _controller.sink.addError(error);
  }

  void close() {
    _controller.close();
  }
}
