abstract class AlphaEvent {}

class AlphaPlayerEvent implements AlphaEvent {}

class AlphaEventsManager {
  void queue(AlphaEvent event) {}
  void next() {}
}
