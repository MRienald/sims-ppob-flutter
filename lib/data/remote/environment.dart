class Environments {
  // ignore: constant_identifier_names
  static const String PRODUCTION = '';
  // ignore: constant_identifier_names
  static const String DEV = 'https://take-home-test-api.nutech-integrasi.app';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'url': 'https://take-home-test-api.nutech-integrasi.app',
    },
    {
      'env': Environments.PRODUCTION,
      'url': '',
    },
  ];

  static String? getEnvironments() {
    return _availableEnvironments
        .firstWhere(
          (d) => d['env'] == _currentEnvironments,
        )
        .values
        .last
        .toString();
  }
}
