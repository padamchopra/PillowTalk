import 'package:flutter/material.dart';
import 'package:pillowtalk/domain/models/generic/event_model.dart';
import 'package:pillowtalk/resources/my_router.dart';

class AuthScreenModel {
  List<AuthScreenFormModel> formModels = [];
  CredentialsFormField currentField = CredentialsFormField.number;
  bool loading = false;
  Event<Screens>? navigateEvent;
  AuthScreenModel({required this.formModels});
}

enum CredentialsFormField { number, password, username }

class AuthScreenFormModel {
  String title;
  String subtitle;
  String placeholder;
  TextInputType textInputType = TextInputType.text;
  Iterable<String>? autofillHints;
  String button;
  bool buttonEnabled = false;
  bool obscureText;
  int? maxLength;
  String? error;

  AuthScreenFormModel({
    required this.title,
    required this.subtitle,
    required this.placeholder,
    required this.textInputType,
    this.autofillHints,
    required this.button,
    this.obscureText = false,
    this.maxLength,
    this.error
  });
}
