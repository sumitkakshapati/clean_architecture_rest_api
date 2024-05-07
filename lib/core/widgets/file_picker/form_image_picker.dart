// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/constants/locale_keys.dart';
import 'package:flutter_clean_architecture_template/core/services/navigation_services.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/custom_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/image_picker_utils.dart';
import 'package:flutter_clean_architecture_template/core/utils/size_utils.dart';
import 'package:flutter_clean_architecture_template/core/widgets/file_picker/image_picker_bottomsheet.dart';
import 'package:flutter_clean_architecture_template/core/widgets/images/custom_network_image.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormImagePicker extends StatefulWidget {
  final String label;
  final ValueChanged<File?>? onChanged;
  final File? initialFile;
  final String fieldName;
  final bool isRequired;
  final String imageUrl;
  final VoidCallback onDeleted;
  const FormImagePicker({
    super.key,
    this.initialFile,
    this.imageUrl = "",
    required this.label,
    this.onChanged,
    required this.fieldName,
    this.isRequired = true,
    required this.onDeleted,
  });

  @override
  State<FormImagePicker> createState() => _FormImagePickerState();
}

class _FormImagePickerState extends State<FormImagePicker> {
  File? _pickedImage;

  String currentImageUrl = "";

  @override
  void initState() {
    currentImageUrl = widget.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomTheme.pagePadding,
        vertical: 16,
      ),
      constraints: BoxConstraints(
        minHeight: 60.hp,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appColorTheme.borderLayout,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: FormBuilderField<File>(
        name: widget.fieldName,
        validator: (value) {
          if (value != null || !widget.isRequired) {
            return null;
          } else {
            return LocaleKeys.fieldCannotBeEmpty.tr(args: [widget.label]);
          }
        },
        initialValue: widget.initialFile,
        builder: (FormFieldState<dynamic> field) {
          return InputDecorator(
            decoration: InputDecoration(
              errorText: field.errorText,
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: appTextTheme.label.copyWith(),
                      ),
                      if (_pickedImage != null || widget.imageUrl.isNotEmpty)
                        SizedBox(height: 8.hp),
                      if (_pickedImage != null || widget.imageUrl.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _pickedImage != null
                              ? Image.file(
                                  _pickedImage!,
                                  height: 68,
                                  width: 68,
                                  fit: BoxFit.cover,
                                )
                              : CustomCachedNetworkImage(
                                  url: widget.imageUrl,
                                  height: 68,
                                  width: 68,
                                  fit: BoxFit.cover,
                                ),
                        ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) {
                        return ImagePickerBottomSheet(
                          onDeletePressed: () {
                            setState(() {
                              widget.onDeleted();
                              currentImageUrl = '';
                              _pickedImage = null;
                              field.didChange(null);
                              NavigationService.pop();
                            });
                          },
                          imagePath: _pickedImage ?? widget.initialFile,
                          imageUrl: widget.imageUrl,
                          onGalleryPressed: () async {
                            final res = await ImagePickerUtils.getGallery();
                            if (res != null) {
                              setState(() {
                                _pickedImage = res;
                                field.didChange(res);
                                if (widget.onChanged != null) {
                                  widget.onChanged!(res);
                                }
                              });
                            }
                            Navigator.pop(context);
                          },
                          onCameraPressed: () async {
                            final res = await ImagePickerUtils.getCamera();
                            if (res != null) {
                              setState(() {
                                _pickedImage = res;
                                field.didChange(res);
                                if (widget.onChanged != null) {
                                  widget.onChanged!(res);
                                }
                              });
                            }
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    switch (_pickedImage) {
                      null => "Add",
                      _ => "Edit",
                    },
                    style: appTextTheme.bodySmallRegular.copyWith(
                      color: appColorTheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
