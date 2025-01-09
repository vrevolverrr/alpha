import 'package:alpha/logic/car_logic.dart';

final class Cars {
  static final List<Car> listings = [
    Car(
        name: "Toyota Corolla",
        price: 16000.0,
        maintenanceCost: 150.0,
        type: CarType.petrol,
        happinessBonus: 50,
        esgBonus: 0),
    Car(
        name: "Tesla Model 3",
        price: 18000,
        maintenanceCost: 300.0,
        type: CarType.electric,
        esgBonus: 40,
        happinessBonus: 80),
    Car(
        name: "Toyota Prius",
        price: 15000,
        maintenanceCost: 200.0,
        type: CarType.hybrid,
        esgBonus: 15,
        happinessBonus: 60),
    Car(
        name: "Nissan Leaf",
        price: 17000,
        maintenanceCost: 250.0,
        type: CarType.electric,
        esgBonus: 30,
        happinessBonus: 70),
  ];
}
