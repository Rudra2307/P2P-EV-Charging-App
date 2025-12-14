class MockStation {
  final String name;
  final double x; // percentage position on map
  final double y;
  final String connector;
  final double price;
  final double speed;
  final bool available;
  final bool isP2P;

  MockStation({
    required this.name,
    required this.x,
    required this.y,
    required this.connector,
    required this.price,
    required this.speed,
    required this.available,
    required this.isP2P,
  });
}

List<MockStation> mockMumbaiStations = [
  MockStation(
    name: "Andheri EV Hub",
    x: 0.45,
    y: 0.38,
    connector: "Type 2",
    price: 18,
    speed: 7.4,
    available: true,
    isP2P: true,
  ),
  MockStation(
    name: "BKC Fast Charge",
    x: 0.52,
    y: 0.48,
    connector: "CCS",
    price: 22,
    speed: 50,
    available: false,
    isP2P: false,
  ),
  MockStation(
    name: "Lower Parel Station",
    x: 0.50,
    y: 0.60,
    connector: "Type 2",
    price: 16,
    speed: 3.3,
    available: true,
    isP2P: false,
  ),
];
