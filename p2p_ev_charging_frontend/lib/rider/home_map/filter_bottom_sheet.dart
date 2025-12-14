import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class FilterOptions {
  String connector;
  bool availableOnly;
  bool p2pOnly;

  FilterOptions({
    this.connector = "All",
    this.availableOnly = false,
    this.p2pOnly = false,
  });
}

Future<FilterOptions?> showFilterSheet(
  BuildContext context,
  FilterOptions current,
) {
  FilterOptions temp = FilterOptions(
    connector: current.connector,
    availableOnly: current.availableOnly,
    p2pOnly: current.p2pOnly,
  );

  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Filters",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: temp.connector,
                  items: ["All", "Type 2", "CCS"]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => temp.connector = v!),
                  decoration: const InputDecoration(labelText: "Connector"),
                ),

                SwitchListTile(
                  value: temp.availableOnly,
                  onChanged: (v) =>
                      setState(() => temp.availableOnly = v),
                  title: const Text("Available Only"),
                ),

                SwitchListTile(
                  value: temp.p2pOnly,
                  onChanged: (v) => setState(() => temp.p2pOnly = v),
                  title: const Text("P2P Only"),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, temp),
                    child: const Text("Apply Filters"),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
