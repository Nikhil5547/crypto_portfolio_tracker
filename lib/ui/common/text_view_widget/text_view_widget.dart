import 'package:crypto_portfolio_tracker/core/export_file.dart';

class TextViewWidget extends StatelessWidget {
  const TextViewWidget({super.key, this.title, this.fontSize, this.textColor, this.fontWeight});

  final String? title;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      maxLines: 2,
      style: TextStyle(fontSize: fontSize ?? 24, fontWeight: fontWeight, color: textColor),
    );
  }
}
