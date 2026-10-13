import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KolomTeksSurat extends StatelessWidget {
  const KolomTeksSurat({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.isNumber = false,
    this.isReadOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.textCapitalization = TextCapitalization.words,
  });

  final String label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool isNumber;
  final bool isReadOnly;
  final int? maxLength;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        enabled: !isReadOnly,
        validator: validator,
        onChanged: onChanged,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : null,
        inputFormatters: isNumber
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(maxLength ?? 16),
              ]
            : null,
        textCapitalization: isNumber
            ? TextCapitalization.none
            : textCapitalization,
        maxLength: maxLength,
        style: isReadOnly
            ? const TextStyle(color: Colors.black87, fontSize: 12)
            : null,
        decoration: InputDecoration(
          floatingLabelBehavior: isReadOnly
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          hintText: label,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          floatingLabelStyle: TextStyle(
            color: AppColors.textSecondaryLight,
            fontSize: 14,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.textSecondaryLight,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: isReadOnly
                  ? AppColors.textSecondaryLight
                  : AppColors.primary,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: isReadOnly ? Colors.grey : AppColors.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
        ),
      ),
    );
  }
}
