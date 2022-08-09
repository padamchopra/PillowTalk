import 'package:pillowtalk/domain/models/auth/auth_form_step.dart';
import 'package:pillowtalk/domain/models/generic/event_model.dart';
import 'package:pillowtalk/resources/my_router.dart';

class LandingScreenModel {
  bool loading = true;
  Event<AuthFormStep>? updateFormStepEvent;
  Event<Screens>? navigateScreenEvent;
}
