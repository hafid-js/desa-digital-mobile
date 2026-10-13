import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class KolomDropdownSurat<T> extends StatelessWidget {
  const KolomDropdownSurat({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    this.validator,
    this.onChanged,
    this.itemBuilder,
  });

  final String label;
  final List<T> items;
  final ValueNotifier<T?> value;
  final FormFieldValidator<T>? validator;
  final ValueChanged<T?>? onChanged;
  final Widget Function(BuildContext, T)? itemBuilder;

  InputDecoration get _decoration => InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 10),
    border: _border(AppColors.primary),
    enabledBorder: _border(AppColors.primary),
    focusedBorder: _border(AppColors.primary),
    disabledBorder: _border(AppColors.primary),
    errorBorder: _border(Colors.redAccent),
    focusedErrorBorder: _border(Colors.redAccent),
  );

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: color, width: 1),
  );

  String _labelOf(T item) => item is String ? item : '$item';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField2<T>(
        isExpanded: true,
        valueListenable: value,
        decoration: _decoration,
        validator: validator,
        hint: Text(
          'Pilih $label',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondaryLight,
          ),
        ),
        items: items
            .map(
              (item) => DropdownItem(
                value: item,
                child:
                    itemBuilder?.call(context, item) ??
                    Text(
                      _labelOf(item),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              ),
            )
            .toList(),
        onChanged: (v) {
          value.value = v;
          onChanged?.call(v);
        },
      ),
    );
  }
}
