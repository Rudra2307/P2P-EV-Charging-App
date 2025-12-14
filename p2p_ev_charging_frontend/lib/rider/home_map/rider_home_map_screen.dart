import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'mock_mumbai_map.dart';
import 'mock_station_data.dart';
import 'filter_bottom_sheet.dart';
import '../station_details/station_details_screen.dart';

class RiderHomeMapScreen extends StatefulWidget {
  const RiderHomeMapScreen({super.key});

  @override
  State<RiderHomeMapScreen> createState() => _RiderHomeMapScreenState();
}

class _RiderHomeMapScreenState extends State<RiderHomeMapScreen> {
  MockStation? selectedStation;
  FilterOptions filters = FilterOptions();

  List<MockStation> get filteredStations {
    return mockMumbaiStations.where((s) {
      if (filters.connector != "All" && s.connector != filters.connector)
        return false;
      if (filters.availableOnly && !s.available) return false;
      if (filters.p2pOnly && !s.isP2P) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MockMumbaiMap(
            stations: filteredStations,
            onStationTap: (s) {
              setState(() => selectedStation = s);
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search area or station",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          Positioned(
            right: 16,
            top: 90,
            child: FloatingActionButton(
              backgroundColor: AppColors.primaryGreen,
              child: const Icon(Icons.tune, color: Colors.black),
              onPressed: () async {
                final result = await showFilterSheet(context, filters);
                if (result != null) {
                  setState(() => filters = result);
                }
              },
            ),
          ),

          if (selectedStation != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _StationPreview(selectedStation!),
            ),
        ],
      ),
    );
  }
}

class _StationPreview extends StatelessWidget {
  final MockStation station;

  const _StationPreview(this.station);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            station.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            "${station.connector} • ${station.speed} kW • ₹${station.price}/kWh",
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StationDetailsScreen()),
              );
            },
            child: const Text("View Details"),
          ),
        ],
      ),
    );
  }
}
