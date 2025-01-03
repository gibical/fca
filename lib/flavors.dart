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
        return 'Mediaverse';
      case Flavor.gibical:
        return 'Gibical';
      case Flavor.ravi:
        return 'Ravi';
      default:
        return 'title';
    }
  }
  static String get packageName {
    switch (appFlavor) {
      case Flavor.mediaverse:
        return 'land.mediaverse.app';
      case Flavor.gibical:
        return 'app.gibical.app';
      case Flavor.ravi:
        return 'ir.app.ravi';
      default:
        return 'land.mediaverse.app';
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
  static String get oAuthCliendID {
    switch (appFlavor) {
      case Flavor.mediaverse:
        return '9ddd87cf-12ac-464b-8fbb-874e88a10b98';
      case Flavor.gibical:
        return '9de0316b-55ad-45a4-85f0-781e05712ff2';
      case Flavor.ravi:
        return '9ddd87cf-12ac-464b-8fbb-874e88a10b98';
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
