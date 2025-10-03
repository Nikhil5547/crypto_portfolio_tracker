import 'package:crypto_portfolio_tracker/core/export_file.dart';
import 'package:crypto_portfolio_tracker/ui/screen/portfolio_screen/widget/portfolio_item.dart';
import 'package:intl/intl.dart';

class PortfolioScreen extends GetView<PortfolioController> {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PortfolioController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: TextViewWidget(title: StringConstants.portfolio, fontWeight: FontWeight.w800, textColor: Colors.white),
          ),
          body: controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : (controller.conList.isEmpty)
              ? Center(child: TextViewWidget(title: StringConstants.noDataFound))
              : RefreshIndicator(
                  onRefresh: () => controller.getCoinListRequest(),
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextViewWidget(title: StringConstants.totalPortfolio, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            TextViewWidget(title: NumberFormat.compactCurrency(symbol: '\$').format(controller.getTotalValue), fontSize: 20),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.conList.length,
                        itemBuilder: (context, index) {
                          HoldingModel ele = controller.conList[index];
                          return PortfolioItem(ele: ele, onDismissed: (_) => controller.removeCoin(index));
                        },
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.to(() => AddAssetScreen())?.then((value) => controller.getCoinListRequest(),),
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }
}
