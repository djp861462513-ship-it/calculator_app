import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String _apiKey = '7f2b0596a21aedba1d68fc51';
  static const String _baseUrl = 'https://v6.exchangerate-api.com/v6';

  Map<String, double> _rates = {};
  Map<String, String> _currencyNames = {};
  DateTime? _lastFetch;
  bool _isLoading = false;

  static const List<String> supportedCurrencies = [
    'USD', 'EUR', 'GBP', 'JPY', 'CNY', 'KRW', 'AUD', 'CAD',
    'CHF', 'HKD', 'SGD', 'INR', 'MXN', 'BRL', 'RUB', 'TRY',
    'THB', 'VND', 'PHP', 'MYR', 'IDR', 'NZD', 'SEK', 'NOK',
    'DKK', 'PLN', 'ZAR', 'AED', 'SAR', 'TWD',
  ];

  static Future<CurrencyService> create({String baseCurrency = 'USD'}) async {
    final service = CurrencyService();
    await service.fetchRates(baseCurrency);
    return service;
  }

  Future<bool> fetchRates(String baseCurrency) async {
    if (_isLoading) return false;
    _isLoading = true;
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$_apiKey/latest/$baseCurrency'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['result'] == 'success') {
          _rates = Map<String, double>.from(
            (data['conversion_rates'] as Map).map(
              (k, v) => MapEntry(k, (v as num).toDouble()),
            ),
          );
          _lastFetch = DateTime.now();
          _currencyNames = {
            'USD': '美元', 'EUR': '欧元', 'GBP': '英镑', 'JPY': '日元',
            'CNY': '人民币', 'KRW': '韩元', 'AUD': '澳元', 'CAD': '加元',
            'CHF': '瑞士法郎', 'HKD': '港币', 'SGD': '新加坡元', 'INR': '印度卢比',
            'MXN': '墨西哥比索', 'BRL': '巴西雷亚尔', 'RUB': '俄罗斯卢布', 'TRY': '土耳其里拉',
            'THB': '泰铢', 'VND': '越南盾', 'PHP': '菲律宾比索', 'MYR': '马来西亚林吉特',
            'IDR': '印尼盾', 'NZD': '新西兰元', 'SEK': '瑞典克朗', 'NOK': '挪威克朗',
            'DKK': '丹麦克朗', 'PLN': '波兰兹罗提', 'ZAR': '南非兰特', 'AED': '阿联酋迪拉姆',
            'SAR': '沙特里亚尔', 'TWD': '新台币',
          };
          _isLoading = false;
          return true;
        }
      }
    } catch (_) {}
    _isLoading = false;
    return false;
  }

  double? convert(double amount, String from, String to) {
    if (_rates.isEmpty) return null;
    final fromRate = _rates[from];
    final toRate = _rates[to];
    if (fromRate == null || toRate == null) return null;
    return amount * (toRate / fromRate);
  }

  String getCurrencyName(String code) => _currencyNames[code] ?? code;
  Map<String, double> get rates => _rates;
  bool get hasData => _rates.isNotEmpty;
  bool get isLoading => _isLoading;
  DateTime? get lastFetch => _lastFetch;
}