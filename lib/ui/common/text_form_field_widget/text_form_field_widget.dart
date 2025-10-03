import 'package:crypto_portfolio_tracker/core/export_file.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({super.key, this.hintText, this.validator, this.onChanged, this.textInputFormatter, this.controller, this.onFieldSubmitted});

  final String? hintText;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? textInputFormatter;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller:controller ,
      inputFormatters: textInputFormatter,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText ?? '',
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxHeight: 60),
      ),
      validator: validator,
    );
  }
}
