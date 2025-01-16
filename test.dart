import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

int generateExpDistESGRating() {
  Random random = Random();

  final List<int> values =
      List.generate(11, (index) => index * 10); // [0, 10, 20, ..., 100]

  // Lambda parameter controls the rate of exponential decay
  const double lambda = 0.02;

  // Calculate weights using exponential distribution: P(x) = λe^(-λx)
  final List<double> weights =
      values.map((x) => lambda * exp(-lambda * x)).toList();

  print(weights.toString());

  // Calculate the sum of weights for normalization
  final double totalWeight = weights.reduce((a, b) => a + b);

  // Generate a random value between 0 and the total weight
  double randomValue = random.nextDouble() * totalWeight;

  // Find the corresponding number based on the random value
  double currentSum = 0;
  for (int i = 0; i < values.length; i++) {
    currentSum += weights[i];
    if (randomValue <= currentSum) {
      return values[i];
    }
  }

  // Fallback
  return values.last;
}

/// This function always yield the same factor for the same inputs.
double generateRandomFactor(String str, int turn, int round) {
  Uint8List bytes = utf8.encode(str);

  int hash = turn + round;

  for (int byte in bytes) {
    hash = ((hash * 33) + byte) & 0xFFFFFFFF;
  }

  hash = ((hash >> 16) ^ hash) * 0x45d9f3b;
  hash = ((hash >> 16) ^ hash) * 0x45d9f3b;
  hash = (hash >> 16) ^ hash;

  double result = (hash & 0xFFFFFFFF) / 0xFFFFFFFF;

  return result;
}

void main() {
  print(generateRandomFactor("DailyDeals", 1, 6));
}
