class ImagePaths {
  static const String root = "assets/images";
}

enum AlphaAssets {
  bgLandingCities(path: "${ImagePaths.root}/bg_landing_cities.png"),
  playerDefault(path: "${ImagePaths.root}/player_default.png"),
  jobProgrammer(path: "${ImagePaths.root}/job_programmer.png");

  const AlphaAssets({required this.path});

  final String path;
}
