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

}
