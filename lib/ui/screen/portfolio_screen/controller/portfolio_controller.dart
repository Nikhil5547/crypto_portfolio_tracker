import 'dart:convert';
import 'package:crypto_portfolio_tracker/core/export_file.dart';

class PortfolioController extends GetxController {
  final PortfolioRepository _portfolioRepository = PortfolioRepository();
  bool isLoading = false;
  List<HoldingModel> conList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCoinListRequest();
    autoRefresh();
  }

  Future<void> autoRefresh() async {
    await Future.delayed(Duration(seconds: 40));
    await getCoinListRequest();
    autoRefresh();
  }

  double get getTotalValue => conList.fold(0.0, (sum, holding) => sum + (holding.totalAmount ?? 0.0)).toPrecision(2);

  Future<void> getCoinListRequest() async {
    isLoading = true;
    conList = [];
    update();
    HoldingResponseModel? data = await _portfolioRepository.loadPortfolio();
    if (data != null) {
      conList = data.holdingList ?? [];
    }
    isLoading = false;
    for (var ele in conList) {
      double totalAmount = await refreshPrices(ele.id ?? '');
      ele.totalAmount = totalAmount * (ele.qty ?? 0);
      ele.amount = totalAmount;
    }
    update();
  }

  Future<double> refreshPrices(String id) async {
    await Future.delayed(Duration(milliseconds: 100));
    return _portfolioRepository.getCoinPrice(ParamsRequest(id: id, type: 'usd'));
  }

  Future<void> removeCoin(int index) async {
    HoldingResponseModel? data = await _portfolioRepository.loadPortfolio();
    conList.removeAt(index);
    data?.holdingList = conList;
    showToast(msg: StringConstants.deletedSuccessfully);
    await SharedPreferencesService().saveCoinList(jsonEncode(data?.toJson()));
    update();
  }
}
