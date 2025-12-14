class StationDetails {
  final String stationName;
  final String hostName;
  final String address;
  final double distanceKm;
  final int etaMinutes;
  final bool available;
  final String bookedUntil;
  final double price;
  final String pricingUnit;
  final List<String> connectors;
  final double speedKw;
  final List<String> rules;
  final double rating;
  final int reviewCount;

  StationDetails({
    required this.stationName,
    required this.hostName,
    required this.address,
    required this.distanceKm,
    required this.etaMinutes,
    required this.available,
    required this.bookedUntil,
    required this.price,
    required this.pricingUnit,
    required this.connectors,
    required this.speedKw,
    required this.rules,
    required this.rating,
    required this.reviewCount,
  });
}
