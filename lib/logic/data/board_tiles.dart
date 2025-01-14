import 'package:alpha/assets.dart';

enum BoardTile {
  careerTile(
      name: "Career",
      description:
          "Earn a salary by working a job and progressing thrugh your career",
      image: AlphaAssets.careerTile),

  educationTile(
      name: "Education",
      description:
          "Invest in your education to increase your earning potential.",
      image: AlphaAssets.educationTile),

  opportunityTile(
      name: "Opportunity",
      description:
          "Draw a card to reveal an opportunity or setback that awaits you.",
      image: AlphaAssets.opportunityTile),

  personalLifeTile(
      name: "Personal Life",
      description: "Progress in your personal life to improve your happiness.",
      image: AlphaAssets.personalLifeTile),

  worldEventTile(
      name: "World Event",
      description: "Trigger a world event that affects all players.",
      image: AlphaAssets.worldEventTile),

  realEstatesTile(
      name: "Real Estates",
      description: "Build wealth through property investment opportunities.",
      image: AlphaAssets.realEstatesTile),

  carTile(
      name: "Car",
      description: "Purchase vehicles to boost your happiness and ESG score.",
      image: AlphaAssets.carTile),

  businessTechnologyTile(
      name: "Business Technology",
      description: "Start a tech business to sell software and hardware.",
      image: AlphaAssets.businessTechnologyTile),

  businessFnBTile(
      name: "Business Food & Beverages",
      description: "Start a food business to sell food and beverages.",
      image: AlphaAssets.businessFnBTile),

  businessEcommerceTile(
      name: "Business E-commerce",
      description: "Start an e-commerce business to sell products online.",
      image: AlphaAssets.businessEcommerceTile),

  businessPharmaTile(
      name: "Business Pharmaceuticals",
      description:
          "Start a pharmaceutical business to develop and sell medicine.",
      image: AlphaAssets.businessPharmaTile),

  businessSocialMediaTile(
      name: "Business Social Media",
      description: "Start a social media business to influence others.",
      image: AlphaAssets.businessSocialMediaTile);

  final String name;
  final String description;
  final AlphaAssets image;

  const BoardTile(
      {required this.name, required this.description, required this.image});
}
