class UnitConversionService {
  static const Map<String, Map<String, double>> conversionFactors = {
    'length': {
      '米 (m)': 1.0,
      '千米 (km)': 1000.0,
      '厘米 (cm)': 0.01,
      '毫米 (mm)': 0.001,
      '英里 (mi)': 1609.344,
      '码 (yd)': 0.9144,
      '英尺 (ft)': 0.3048,
      '英寸 (in)': 0.0254,
    },
    'weight': {
      '千克 (kg)': 1.0,
      '克 (g)': 0.001,
      '毫克 (mg)': 0.000001,
      '吨 (t)': 1000.0,
      '磅 (lb)': 0.453592,
      '盎司 (oz)': 0.0283495,
      '克拉 (ct)': 0.0002,
    },
    'temperature': {
      '摄氏度 (°C)': 'celsius',
      '华氏度 (°F)': 'fahrenheit',
      '开尔文 (K)': 'kelvin',
    },
    'area': {
      '平方米 (m²)': 1.0,
      '平方千米 (km²)': 1000000.0,
      '公顷 (ha)': 10000.0,
      '英亩 (ac)': 4046.856,
      '平方英尺 (ft²)': 0.092903,
      '平方英寸 (in²)': 0.00064516,
    },
    'volume': {
      '升 (L)': 1.0,
      '毫升 (mL)': 0.001,
      '立方米 (m³)': 1000.0,
      '加仑 (gal)': 3.78541,
      '夸脱 (qt)': 0.946353,
      '品脱 (pt)': 0.473176,
      '杯 (cup)': 0.236588,
    },
    'speed': {
      '米/秒 (m/s)': 1.0,
      '千米/时 (km/h)': 0.277778,
      '英里/时 (mph)': 0.44704,
      '节 (kn)': 0.514444,
      '马赫 (Ma)': 340.3,
    },
  };

  static List<String> get categories => conversionFactors.keys.toList();

  static List<String> getUnits(String category) {
    return conversionFactors[category]?.keys.toList() ?? [];
  }

  static double? convert(double value, String from, String to, String category) {
    if (category == 'temperature') {
      return _convertTemperature(value, from, to);
    }
    final factors = conversionFactors[category];
    if (factors == null) return null;
    final fromFactor = factors[from];
    final toFactor = factors[to];
    if (fromFactor == null || toFactor == null) return null;
    return value * (fromFactor as double) / (toFactor as double);
  }

  static double? _convertTemperature(double value, String from, String to) {
    double celsius;
    switch (from) {
      case '摄氏度 (°C)':
        celsius = value;
        break;
      case '华氏度 (°F)':
        celsius = (value - 32) * 5 / 9;
        break;
      case '开尔文 (K)':
        celsius = value - 273.15;
        break;
      default:
        return null;
    }
    switch (to) {
      case '摄氏度 (°C)':
        return celsius;
      case '华氏度 (°F)':
        return celsius * 9 / 5 + 32;
      case '开尔文 (K)':
        return celsius + 273.15;
      default:
        return null;
    }
  }
}