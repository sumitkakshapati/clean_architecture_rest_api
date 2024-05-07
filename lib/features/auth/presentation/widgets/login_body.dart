import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_template/core/bloc/common_state.dart';
import 'package:flutter_clean_architecture_template/core/constants/locale_keys.dart';
import 'package:flutter_clean_architecture_template/core/enum/text_field_type.dart';
import 'package:flutter_clean_architecture_template/core/forms/common_form_attributes.dart';
import 'package:flutter_clean_architecture_template/core/routes/routes.dart';
import 'package:flutter_clean_architecture_template/core/theme/custom_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/form_validator.dart';
import 'package:flutter_clean_architecture_template/core/utils/snackbar_utils.dart';
import 'package:flutter_clean_architecture_template/core/widgets/button/custom_rounded_button.dart';
import 'package:flutter_clean_architecture_template/core/wrapper/bloc_listener_wrapper.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/param/login_param.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture_template/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  List<CommonFormAttributes> _forms = [];
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  void initState() {
    _forms = [
      TextFieldFormAttribute(
        label: LocaleKeys.email.tr(),
        hintText: LocaleKeys.email.tr(),
        fieldName: "email",
        keyboardType: TextInputType.emailAddress,
        validator: FormValidator.validateEmail,
      ),
      TextFieldFormAttribute(
        label: LocaleKeys.password.tr(),
        hintText: LocaleKeys.password.tr(),
        fieldName: "password",
        textFieldType: TextFieldType.Password,
        validator: FormValidator.validatePassword,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CustomTheme.pagePadding,
        ),
        child: BlocListenerWrapper<LoginCubit>(
          listener: (context, state) {
            if (state is CommonSuccessState<User>) {
              SnackBarUtils.showSuccessMessage(
                context: context,
                message: LocaleKeys.loggedInSuccessfully.tr(),
              );
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.dashboard,
                (route) => false,
              );
            }
          },
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                ..._forms.build(),
                CustomRoundedButtom(
                  title: LocaleKeys.login.tr().toUpperCase(),
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      context.read<LoginCubit>().login(
                            LoginParam(
                              email: _formKey.currentState!.value["email"],
                              password:
                                  _formKey.currentState!.value["password"],
                            ),
                          );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
