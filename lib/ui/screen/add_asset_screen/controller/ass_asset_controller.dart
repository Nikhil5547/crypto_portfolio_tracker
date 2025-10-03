import 'dart:convert';

import 'package:crypto_portfolio_tracker/core/export_file.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class AssAssetController extends GetxController {
  final PortfolioRepository _portfolioRepository = PortfolioRepository();
  bool isLoading = false;
  List<CoinResponseModel> conList = [];
  CoinResponseModel? selectedConList = CoinResponseModel();
  int qty = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCoinListRequest();
  }

  Future<void> getCoinListRequest() async {
    isLoading = true;
    conList = await _portfolioRepository.getCoinLIstApiCall();
    isLoading = false;
  }

  void onSelect(CoinResponseModel value) {
    selectedConList = value;
  }

  void setQty(String value) {
    qty = int.parse(value.trim());
  }

  Future<void> addPortfolio() async {
    if(selectedConList != null){
      HoldingResponseModel? data = await _portfolioRepository.loadPortfolio();
      if (data != null) {
        if (data.holdingList?.indexWhere((ele) => ele.id == selectedConList?.id) == -1) {
          data.holdingList?.add(HoldingModel(name: selectedConList?.name, id: selectedConList?.id, symbol: selectedConList?.symbol, qty: qty));
          Get.back();
          showToast(msg: StringConstants.addedSuccessfully, backgroundColor: Colors.green);
        } else {
          showToast(msg: StringConstants.alreadyAdded);
        }
      } else {
        data = HoldingResponseModel(
          holdingList: [HoldingModel(name: selectedConList?.name, id: selectedConList?.id, symbol: selectedConList?.symbol, qty: qty)],
        );
        Get.back();
        showToast(msg: StringConstants.addedSuccessfully, backgroundColor: Colors.green);
      }
      await SharedPreferencesService().saveCoinList(jsonEncode(data.toJson()));
      selectedConList = null;
    }else{
      showToast(msg: StringConstants.searchAndSelectCoinItem);
    }
  }
}
