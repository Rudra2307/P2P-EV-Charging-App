import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  double durationHours = 1;
  final double pricePerKwh = 18;
  final double avgKw = 7.4;

  String selectedPayment = "Wallet";

  double get estimatedEnergy => durationHours * avgKw;
  double get estimatedCost => estimatedEnergy * pricePerKwh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Book Charging")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DateTimeCard(
              date: selectedDate,
              time: selectedTime,
              onDateTap: _pickDate,
              onTimeTap: _pickTime,
            ),
            const SizedBox(height: 20),
            _DurationCard(
              duration: durationHours,
              onChanged: (v) => setState(() => durationHours = v),
            ),
            const SizedBox(height: 20),
            _CostBreakdownCard(energy: estimatedEnergy, cost: estimatedCost),
            const SizedBox(height: 20),
            _PaymentMethodCard(
              selected: selectedPayment,
              onChanged: (v) => setState(() => selectedPayment = v),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _ConfirmCTA(cost: estimatedCost),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (time != null) setState(() => selectedTime = time);
  }
}

/* -------------------------------------------------------
 DATE & TIME
--------------------------------------------------------*/
class _DateTimeCard extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final VoidCallback onDateTap;
  final VoidCallback onTimeTap;

  const _DateTimeCard({
    required this.date,
    required this.time,
    required this.onDateTap,
    required this.onTimeTap,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: "Date & Time",
      child: Row(
        children: [
          _Selector(
            icon: Icons.calendar_today,
            label: "${date.day}/${date.month}/${date.year}",
            onTap: onDateTap,
          ),
          const SizedBox(width: 12),
          _Selector(
            icon: Icons.access_time,
            label: time.format(context),
            onTap: onTimeTap,
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------
 DURATION
--------------------------------------------------------*/
class _DurationCard extends StatelessWidget {
  final double duration;
  final ValueChanged<double> onChanged;

  const _DurationCard({required this.duration, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: "Estimated Duration",
      child: Column(
        children: [
          Slider(
            value: duration,
            min: 0.5,
            max: 8,
            divisions: 15,
            label: "${duration.toStringAsFixed(1)} hrs",
            onChanged: onChanged,
          ),
          Text(
            "${duration.toStringAsFixed(1)} hours",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------
 COST BREAKDOWN
--------------------------------------------------------*/
class _CostBreakdownCard extends StatelessWidget {
  final double energy;
  final double cost;

  const _CostBreakdownCard({required this.energy, required this.cost});

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: "Estimated Cost",
      child: Column(
        children: [
          _Row("Energy", "${energy.toStringAsFixed(1)} kWh"),
          _Row("Price", "₹18 / kWh"),
          const Divider(),
          _Row("Total", "₹${cost.toStringAsFixed(0)}", highlight: true),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------
 PAYMENT METHOD
--------------------------------------------------------*/
class _PaymentMethodCard extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _PaymentMethodCard({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: "Payment Method",
      child: Column(
        children: [
          _PaymentTile(
            label: "Wallet",
            selected: selected == "Wallet",
            onTap: () => onChanged("Wallet"),
          ),
          _PaymentTile(
            label: "Credit / Debit Card",
            selected: selected == "Card",
            onTap: () => onChanged("Card"),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------
 BOTTOM CTA
--------------------------------------------------------*/
class _ConfirmCTA extends StatelessWidget {
  final double cost;

  const _ConfirmCTA({required this.cost});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.surface,
      child: SizedBox(
        height: 52,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "Confirm & Pay  ₹${cost.toStringAsFixed(0)}",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------
 REUSABLE UI
--------------------------------------------------------*/
class _Card extends StatelessWidget {
  final String title;
  final Widget child;

  const _Card({required this.title, required this.child});

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
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Selector extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _Selector({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primaryGreen),
              const SizedBox(width: 10),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String left;
  final String right;
  final bool highlight;

  const _Row(this.left, this.right, {this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(left),
          const Spacer(),
          Text(
            right,
            style: TextStyle(
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: highlight ? AppColors.primaryGreen : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: AppColors.primaryGreen,
      ),
      title: Text(label),
    );
  }
}
