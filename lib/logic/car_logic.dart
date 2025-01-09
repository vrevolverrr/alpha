import 'package:alpha/assets.dart';
import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/cars.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:logging/logging.dart';

enum CarType {
  petrol(name: "Petrol", image: AlphaAssets.carPetrol),
  hybrid(name: "Hybrid", image: AlphaAssets.carHybrid),
  electric(name: "Electric", image: AlphaAssets.carElectric);

  const CarType({required this.name, required this.image});

  final String name;
  final AlphaAssets image;
}

class Car {
  final String name;
  final CarType type;

  final double price;
  final double depreciationRate;
  final double maintenanceCost;
  final int repaymentPeriod;

  final int timeBonus;
  final int esgBonus;
  final int happinessBonus;

  double get loanAmount => price * 0.8;
  double get unpaidLoan => price - loanAmount;
  double get upfrontPayment => price * 0.2;
  double get repaymentPerRound => loanAmount / repaymentPeriod;

  Car({
    required this.name,
    required this.price,
    this.depreciationRate = 8.5,
    required this.maintenanceCost,
    this.repaymentPeriod = 8,
    required this.type,
    required this.happinessBonus,
    required this.esgBonus,
    this.timeBonus = 120,
  });
}

class CarOwnership {
  final Car car;
  final int ownedRound;
  final Player player;

  CarOwnership(
      {required this.car, required this.ownedRound, required this.player});
}

class CarManager implements IManager {
  @override
  final Logger log = Logger("CarManager");

  final List<CarOwnership> _ownedCars = [];

  double calculateCOEPrice() {
    int numCars = _ownedCars.length;

    double baseCOE = 1000.0;
    double coePrice = baseCOE + (numCars * 500);

    return coePrice;
  }

  void buyCar(Player player, Car car) {
    double totalPrice = car.price + calculateCOEPrice();

    bool bought = player.savings.deduct(totalPrice);
  }

  void sellCar(Car car) {
    log.info("Car ${car.name} sold");
  }

  void deductMaintenanceCosts() {
    for (CarOwnership ownership in _ownedCars) {
      ownership.player.savings.deduct(ownership.car.maintenanceCost);
    }
  }

  List<Car> getAvailableCars(Player player) {
    return Cars.listings
        .where((car) => !_ownedCars.any((o) => o.car == car))
        .toList();
  }

  double getCurrentCarValue(Player player, Car car) {
    int roundsOwned = _ownedCars
        .where((o) => o.player == player && o.car == car)
        .map((o) => o.ownedRound)
        .reduce((a, b) => a + b);

    double value = car.price * (1 - (car.depreciationRate * roundsOwned));

    return value;
  }
}
