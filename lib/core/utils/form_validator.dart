import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_clean_architecture_template/core/constants/locale_keys.dart';
import 'package:flutter_clean_architecture_template/core/utils/text_utils.dart';

class FormValidator {
  static String? validateEmail(String? val, [bool supportEmpty = false]) {
    if (supportEmpty && (val == null || val.isEmpty)) {
      return null;
    } else if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [LocaleKeys.email.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [LocaleKeys.email.tr()]);
    } else if (TextUtils.validateEmail(val)) {
      return null;
    } else {
      return LocaleKeys.pleaseEnterValidField.tr(args: [LocaleKeys.email.tr()]);
    }
  }

  static String? validatePassword(String? val, {String? label}) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.length >= 6) {
      return null;
    } else {
      return LocaleKeys.invalidPasswordMessage
          .tr(args: [label ?? LocaleKeys.password.tr(), "6"]);
    }
  }

  static String? validateConfirmPassword(String? val, String? newPassword,
      {String? label}) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.length >= 6) {
      if (val == newPassword) {
        return null;
      } else {
        return LocaleKeys.doesnotMatch.tr(
          args: [label ?? LocaleKeys.confirmPassword.tr()],
        );
      }
    } else {
      return LocaleKeys.invalidPasswordMessage.tr(
        args: [label ?? LocaleKeys.password.tr(), "6"],
      );
    }
  }

  static String? validatePhoneNumber(String? val) {
    final RegExp regExp = RegExp(r'([9][678][0-6][0-9]{7})');
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [LocaleKeys.phoneNumber.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [LocaleKeys.phoneNumber.tr()]);
    } else if (val.length != 10 || !regExp.hasMatch(val)) {
      return LocaleKeys.enterValidPhoneNumber.tr();
    } else {
      return null;
    }
  }

  static String? validateFieldNotEmpty(String? val, String fieldName) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else {
      return null;
    }
  }
}
