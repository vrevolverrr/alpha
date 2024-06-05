class ImagePaths {
  static const String root = "assets/images";
}

enum AlphaAssets {
  bgLandingCities(path: "${ImagePaths.root}/bg_landing_cities.png"),
  playerDefault(path: "${ImagePaths.root}/player_default.png");

  const AlphaAssets({required this.path});

  final String path;
}
