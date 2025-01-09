enum GameTile {
  workTile(
      tileName: "Work",
      tileDescription: "You may choose a to work at a new job "
          "or progress your career in your current job"),

  businessTile(
      tileName: "Business",
      tileDescription:
          "You may choose to start a new business in a specific industry "
          "to earn side income"),

  insuranceTile(
      tileName: "Insurance",
      tileDescription:
          "You may choose to purchase insurance to provide financial "
          "protection during a mishap"),

  oppurtunityTile(
      tileName: "Opportunity",
      tileDescription: "You will be given a random oppurtunity that may "
          "provide you with significant help"),

  lifeTile(
      tileName: "Life Event",
      tileDescription:
          "You may choose a life event to be triggered in order to "
          "progress in your personal life"),

  eventTile(
      tileName: "World Event",
      tileDescription: "You may choose a world event to be triggered that "
          "will affect the state of the game");

  const GameTile({required this.tileName, required this.tileDescription});

  final String tileName;
  final String tileDescription;
}
