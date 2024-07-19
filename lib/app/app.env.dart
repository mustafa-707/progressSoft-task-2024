enum AppEnv {
  staging,
  production,
}

class AppFromEnv {
  static const _selectedEnv = String.fromEnvironment('ENV');
  static AppEnv get appEnv {
    switch (_selectedEnv) {
      case 'staging':
        return AppEnv.staging;
      case 'production':
        return AppEnv.production;
      default:
        throw Exception('Unknown environment: $_selectedEnv');
    }
  }
}
