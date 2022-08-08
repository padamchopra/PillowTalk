import 'package:pillowtalk/presentation/screens/view_model_listener.dart';

abstract class ViewModel {
  Set<ViewModelListener> listeners = {};

  void addListener(ViewModelListener listener) {
    listeners.add(listener);
  }

  void removeListener(ViewModelListener listener) {
    listeners.remove(listener);
  }

  void notify() {
    for (var listener in listeners) {
      listener.onUpdateNotification();
    }
  }

  void dispose();
}
