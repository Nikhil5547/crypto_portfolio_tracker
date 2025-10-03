import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto_portfolio_tracker/core/export_file.dart';

class PortfolioRepository {
  CommonApiCallMethods _apiCallMethods = CommonApiCallMethods();

  Future<List<CoinResponseModel>> getCoinLIstApiCall() async {
    List<CoinResponseModel> conList = [];
    final url = Uri.parse(ApiConstants.getCoinList);
    try {
      final response = await CommonApiCallMethods.getApiResponseData(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        log('Response: ${response.body}');
        conList = jsonList.map((json) => CoinResponseModel.fromJson(json)).toList();
      } else {
        showToast(msg: jsonDecode(response.body)['status']['error_message'].toString());
      }
    } on SocketException catch (e) {
      log('Error: $e');
    } catch (e) {
      log('Error: $e');
    }
    return conList;
  }

  Future<double> getCoinPrice(ParamsRequest request) async {
    final url = Uri.parse(ApiConstants.getPriceFromCoinId.formatWithMap(request.toJson()));
    try {
      final response = await CommonApiCallMethods.getApiResponseData(url);
      final Map jsonList = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log('Response: ${response.body}');
        return double.parse(jsonList[request.id][request.type].toString());
      } else {
        showToast(msg: jsonList['status']['error_message'].toString());
      }
    } on SocketException catch (e) {
      log('Error: $e');
    } catch (e) {
      log('Error: $e');
    }
    return 0.0;
  }

  Future<HoldingResponseModel?> loadPortfolio() async {
    final value = SharedPreferencesService.getCoinList;
    if (value.isNotEmpty) {
      try {
        return HoldingResponseModel.fromJson(jsonDecode(value));
      } catch (e) {
        print('Error: $e');
        return null;
      }
    }
    return null;
  }
}
