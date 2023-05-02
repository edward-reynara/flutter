class Env {
  var baseUrl;

  Env(this.baseUrl);
}

mixin EnvValue {
  static final Env production = Env('https://warranty.compro.co.id/api');
  static final Env development = Env('https://warranty.compro.co.id/api');
}
