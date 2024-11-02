enum Flavor {
  mediaverse,
  gibical,
  ravi,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.mediaverse:
        return 'MediaVerse App';
      case Flavor.gibical:
        return 'Gibical App';
      case Flavor.ravi:
        return 'Ravi App';
      default:
        return 'title';
    }
  }
  static String get assetTitle {
    switch (appFlavor) {
      case Flavor.mediaverse:
        return 'mediaverse';
      case Flavor.gibical:
        return 'gibical';
      case Flavor.ravi:
        return 'ravi';
      default:
        return 'mediaverse';
    }
  }
  static String get apiurl {
    switch (appFlavor) {
      case Flavor.mediaverse:
        return 'https://api.mediaverse.land/v2/';
      case Flavor.gibical:
        return "https://api.${("gibical.app")}/v2/";
      case Flavor.ravi:
        return 'https://api.mediaverse.land/v2/';
      default:
        return 'https://api.mediaverse.land/v2/';
    }
  }

}
