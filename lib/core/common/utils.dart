import 'package:crypto_portfolio_tracker/core/export_file.dart';

void showToast({required String msg, Color? backgroundColor}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: backgroundColor ?? Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
