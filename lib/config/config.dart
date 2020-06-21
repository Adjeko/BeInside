// Set to true if loginscreen should be displayed at startup (only for releases not for dev setup)
const properties = const Properties(false);

class Properties {
  final bool loginEnabledByDefault;
  const Properties(this.loginEnabledByDefault);
}
