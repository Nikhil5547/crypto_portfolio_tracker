import 'dart:developer';

import 'package:crypto_portfolio_tracker/core/common/api_constants.dart';
import 'package:http/http.dart' as http;

class CommonApiCallMethods {
  // Get get response data
  static getApiResponseData(url, {Map<String, String>? headers}) async {
    final futureResult = await http.get(
      ApiConstants.endpointUri(url.path, queryParameters: url.queryParameters),
      headers: headers ?? ApiConstants.header(),
    );
    log(
      " ---------------------- \n URL ${ApiConstants.endpointUri(url.path, queryParameters: url.queryParameters)} \n Status Code:- ${futureResult.statusCode} \n Response Body:- ${futureResult.body} \n ----------------------",
    );
    return futureResult;
  }
}
