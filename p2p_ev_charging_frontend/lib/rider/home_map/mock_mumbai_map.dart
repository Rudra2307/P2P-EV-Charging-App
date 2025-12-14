import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'mock_station_data.dart';

class MockMumbaiMap extends StatelessWidget {
  final List<MockStation> stations;
  final Function(MockStation) onStationTap;

  const MockMumbaiMap({
    super.key,
    required this.stations,
    required this.onStationTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Stack(
          children: [
            // MAP IMAGE
            Positioned.fill(
              child: Image.asset(
                "assets/images/mumbai_map_dark.jpg",
                fit: BoxFit.cover,
              ),
            ),

            // CURRENT LOCATION (Andheri mock)
            Positioned(
              left: constraints.maxWidth * 0.48,
              top: constraints.maxHeight * 0.40,
              child: const Icon(
                Icons.my_location,
                color: Colors.blueAccent,
                size: 20,
              ),
            ),

            // STATION PINS
            ...stations.map((station) {
              return Positioned(
                left: constraints.maxWidth * station.x,
                top: constraints.maxHeight * station.y,
                child: GestureDetector(
                  onTap: () => onStationTap(station),
                  child: Icon(
                    Icons.ev_station,
                    size: 30,
                    color: station.available
                        ? AppColors.primaryGreen
                        : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
