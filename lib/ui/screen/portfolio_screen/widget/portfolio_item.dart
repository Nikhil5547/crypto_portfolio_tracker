import 'package:crypto_portfolio_tracker/core/export_file.dart';
import 'package:intl/intl.dart';

class PortfolioItem extends StatelessWidget {
  const PortfolioItem({super.key, required this.ele, this.onDismissed});

  final HoldingModel ele;
  final DismissDirectionCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: onDismissed,
        background: Container(
          alignment: Alignment.centerRight,
          color: Colors.red,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete_forever, color: Colors.white),
        ),
        child: Column(
          children: [
            item(StringConstants.symbol, (ele.symbol ?? '').toUpperCase()),
            item(StringConstants.name, ele.name ?? ''),
            item(StringConstants.qty, (ele.qty ?? '0').toString()),
            item(StringConstants.price, price),
            item(StringConstants.totalAmount, totalAmount),
          ],
        ),
      ),
    );
  }

  Widget item(String title, String subTitle) {
    return Row(
      children: [
        Flexible(
          child: TextViewWidget(title: title, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        TextViewWidget(title: subTitle, fontSize: 16),
      ],
    );
  }

  String get totalAmount => NumberFormat.compactCurrency(symbol: '\$').format(ele.totalAmount ?? 0);

  String get price => NumberFormat.compactCurrency(symbol: '\$').format(ele.amount ?? 0);
}
