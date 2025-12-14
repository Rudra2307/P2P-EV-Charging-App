import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            _UserHeader(),
            SizedBox(height: 24),

            _Section(
              title: "Account",
              tiles: [
                _ProfileTile(icon: Icons.directions_car, title: "My Vehicles"),
                _ProfileTile(icon: Icons.bookmark, title: "Saved Stations"),
              ],
            ),

            SizedBox(height: 16),

            _Section(
              title: "Payments",
              tiles: [
                _ProfileTile(
                  icon: Icons.account_balance_wallet,
                  title: "Wallet & Payment Methods",
                ),
                _ProfileTile(
                  icon: Icons.receipt_long,
                  title: "Transaction History",
                ),
              ],
            ),

            SizedBox(height: 16),

            _Section(
              title: "Settings",
              tiles: [
                _ProfileTile(icon: Icons.notifications, title: "Notifications"),
                _ProfileTile(icon: Icons.help_outline, title: "Help & FAQ"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------
 USER HEADER
--------------------------------------------------------*/
class _UserHeader extends StatelessWidget {
  const _UserHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryGreen,
            child: Icon(Icons.person, size: 32, color: Colors.black),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rudra Trivedi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text("+91 9XXXXXXXXX", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.edit, color: AppColors.primaryGreen),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------
 SECTION
--------------------------------------------------------*/
class _Section extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const _Section({required this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...tiles,
        ],
      ),
    );
  }
}

/* -------------------------------------------------------
 TILE
--------------------------------------------------------*/
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ProfileTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primaryGreen),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Navigate to respective screen later
      },
    );
  }
}
