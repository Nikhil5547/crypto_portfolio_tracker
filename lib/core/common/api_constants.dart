class ApiConstants {
  static const int defaultTimeout = 10;
  static const int cachedDays = 7;
  static const String scheme = 'https';

  static String apiHost = 'api.coingecko.com';

  static Uri endpointUri(path, {Map<String, dynamic>? queryParameters}) =>
      Uri(scheme: scheme, host: apiHost, path: path, queryParameters: queryParameters);

  static Map<String, String> header() {
    Map<String, String> headerData = {'Content-Type': 'application/json', 'Authorization': 'Bearer '};

    return headerData;
  }

  static String endPoint = "api/v3";
  static String getCoinList = "$endPoint/coins/list";
  static String getPriceFromCoinId = "$endPoint/simple/price?ids={id}&vs_currencies={type}";
}
