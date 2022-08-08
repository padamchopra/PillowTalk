import 'package:flutter/material.dart';
import 'package:pillowtalk/domain/models/auth/auth_form_step.dart';
import 'package:pillowtalk/domain/models/generic/error_message_model.dart';
import 'package:pillowtalk/domain/models/generic/event_model.dart';
import 'package:pillowtalk/domain/usecases/auth/auth_form_step_use_case.dart';
import 'package:pillowtalk/presentation/screens/auth/auth_screen_models.dart';
import 'package:pillowtalk/presentation/screens/view_model.dart';
import 'package:pillowtalk/resources/my_router.dart';

class AuthViewModel extends ViewModel {
  final AuthFormStepUseCase _useCase = AuthFormStepUseCase();

  late AuthScreenModel _screenModel;
  AuthScreenModel get screenModel => _screenModel;

  AuthViewModel() {
    _buildScreenModel();
    _useCase.stream.listen((step) {
      _handleStateStepChange(step);
    },
      onError: (error) {
        ErrorMessageModel errorMessage = error;
        _setErrorMessage(errorMessage.message);
        _setLoading(false);
      }
    );
  }

  String _phoneNumber = "";
  String _otpCode = "";
  String _username = "";

  void _handleStateStepChange(AuthFormStep step) {
    switch(step) {
      case AuthFormStep.phone: {
        if (_screenModel.currentField != CredentialsFormField.number) {
          _screenModel.currentField = CredentialsFormField.number;
        }
        break;
      }
      case AuthFormStep.code: {
        if (_screenModel.currentField != CredentialsFormField.password) {
          _screenModel.currentField = CredentialsFormField.password;
        }
        break;
      }
      case AuthFormStep.username: {
        if (_screenModel.currentField != CredentialsFormField.username) {
          _screenModel.currentField = CredentialsFormField.username;
        }
        break;
      }
      case AuthFormStep.finished: {
        _screenModel.navigateEvent = Event(Screens.home);
      }
    }
    _setLoading(false);
  }

  void _buildScreenModel() {
    _screenModel = AuthScreenModel(
      formModels: [
        AuthScreenFormModel(
          title: "Enter your\nphone number",
          subtitle: "We currently only support US/Canadian numbers.",
          placeholder: "000 000 0000",
          textInputType: TextInputType.number,
          button: "Continue",
          autofillHints: const [AutofillHints.telephoneNumberDevice],
          maxLength: 10,
        ),
        AuthScreenFormModel(
          title: "Enter your\nOTP code",
          subtitle: "It was just sent to your phone.",
          placeholder: "OTP",
          textInputType: TextInputType.number,
          button: "Continue",
          autofillHints: const [AutofillHints.oneTimeCode],
          maxLength: 6,
        ),
        AuthScreenFormModel(
          title: "Choose your new\nusername",
          subtitle: "This is how you'll be discovered by others",
          placeholder: "@username",
          textInputType: TextInputType.text,
          button: "Done",
          autofillHints: const [AutofillHints.username],
        )
      ],
    );
    notify();
  }


  // region handle input change
  void onInputChange(String text) {
    switch (_screenModel.currentField) {
      case CredentialsFormField.number:
        {
          _onNumberUpdate(text);
        }
        break;
      case CredentialsFormField.password:
        {
          _onCodedUpdate(text);
        }
        break;
      case CredentialsFormField.username:
        {
          _onUsernameUpdate(text);
        }
        break;
    }
  }

  void _onNumberUpdate(String text) {
    _phoneNumber = text.trim();
    bool alreadyEnabled = _screenModel.formModels.elementAt(CredentialsFormField.number.index).buttonEnabled;
    if (_phoneNumber.length == 10 && !alreadyEnabled) {
      _screenModel.formModels.elementAt(CredentialsFormField.number.index).buttonEnabled = true;
      notify();
    } else if (_phoneNumber.length != 10 && alreadyEnabled) {
      _screenModel.formModels.elementAt(CredentialsFormField.number.index).buttonEnabled = false;
      notify();
    }
  }

  void _onCodedUpdate(String text) {
    _otpCode = text.trim();
    bool alreadyEnabled = _screenModel.formModels.elementAt(CredentialsFormField.password.index).buttonEnabled;
    if (_otpCode.length == 6 && !alreadyEnabled) {
      _screenModel.formModels.elementAt(CredentialsFormField.password.index).buttonEnabled = true;
      notify();
    } else if (_otpCode.length != 6 && alreadyEnabled) {
      _screenModel.formModels.elementAt(CredentialsFormField.password.index).buttonEnabled = false;
      notify();
    }
  }

  void _onUsernameUpdate(String text) {
    _username = text.trim();
    bool alreadyEnabled = _screenModel.formModels.elementAt(CredentialsFormField.username.index).buttonEnabled;
    if (_username.contains(" ") || _username.contains("@")) {
      _setErrorMessage("No spaces or @ allowed in the username");
      if (alreadyEnabled) {
        _screenModel.formModels.elementAt(CredentialsFormField.username.index).buttonEnabled = false;
      }
      notify();
      return;
    }

    if (_username.length > 3 && !alreadyEnabled) {
      _screenModel.formModels.elementAt(CredentialsFormField.username.index).buttonEnabled = true;
      notify();
    } else if (_username.length <= 3 && alreadyEnabled) {
      _screenModel.formModels.elementAt(CredentialsFormField.username.index).buttonEnabled = false;
      notify();
    }
  }

  // region ends

  // region handle button click
  void onButtonClick() {
    _setErrorMessage(null);
    _setLoading(true);
    switch (_screenModel.currentField) {
      case CredentialsFormField.number:
        {
          _phoneNumber = "+1 $_phoneNumber";
          _useCase.submitPhoneNumber(_phoneNumber);
        }
        break;
      case CredentialsFormField.password:
        {
          _useCase.submitCode(_phoneNumber, _otpCode);
        }
        break;
      case CredentialsFormField.username:
        {
          _useCase.submitUsername(_username);
        }
        break;
    }
  }

  // region ends

  void _setLoading(bool loading) {
    if (_screenModel.loading != loading) {
      _screenModel.loading = loading;
      notify();
    }
  }

  void _setErrorMessage(String? msg) {
    _screenModel.formModels.elementAt(
        _screenModel.currentField.index
    ).error = msg;
  }

  @override
  void dispose() {
    _useCase.close();
  }
}