import 'package:pillowtalk/domain/models/generic/result_model.dart';

abstract class GetterUserCase<T> {
  Result<T> get data;
}
