enum Flavor {
  prod,
  stage,
  dev,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'AVK';
      case Flavor.stage:
        return 'AVK Stage';
      case Flavor.dev:
        return 'AVK Dev';
    }
  }

}
