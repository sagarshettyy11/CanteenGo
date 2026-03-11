import 'package:flutter/material.dart';

class CanteenGoCheckoutApp extends StatelessWidget {
  const CanteenGoCheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo - Checkout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Public Sans',
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
      ),
      home: const CheckoutScreen(),
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color _primary = Color(0xFFEC5B13);
  static const Color _brandRed = Color(0xFFC8102E);

  int _selectedPickup = 0; // 0=ASAP, 1=15min, 2=30min
  int _selectedPayment = 0; // 0=UPI, 1=Card, 2=Wallet

  final List<String> _pickupOptions = ['ASAP', '15 min', '30 min'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable content
            Padding(
              padding: const EdgeInsets.only(bottom: 88),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopNav(),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _buildPickupTimeSection(),
                    _buildPaymentMethodSection(),
                    _buildOrderSummarySection(),
                  ],
                ),
              ),
            ),
            // Fixed bottom bar
            Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomBar()),
          ],
        ),
      ),
    );
  }

  // ── Top Navigation ──────────────────────────────────────────────────────────

  Widget _buildTopNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
            style: IconButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Checkout',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart, color: Color(0xFF0F172A)),
          ),
        ],
      ),
    );
  }

  // ── Pickup Time ─────────────────────────────────────────────────────────────

  Widget _buildPickupTimeSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pickup Time',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_pickupOptions.length, (index) {
                final selected = _selectedPickup == index;
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < _pickupOptions.length - 1 ? 12 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedPickup = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: selected ? _primary : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected ? _primary : Colors.transparent,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _pickupOptions[index],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: selected
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ── Payment Method ───────────────────────────────────────────────────────────

  Widget _buildPaymentMethodSection() {
    final methods = [
      _PaymentMethod(
        icon: Icons.account_balance_wallet_outlined,
        title: 'UPI',
        subtitle: 'Google Pay, PhonePe, Paytm',
      ),
      _PaymentMethod(
        icon: Icons.credit_card,
        title: 'Debit/Credit Card',
        subtitle: 'Visa, Mastercard, RuPay',
      ),
      _PaymentMethod(
        icon: Icons.wallet_outlined,
        title: 'Wallet',
        subtitle: 'Amazon Pay, Mobikwik',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(methods.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < methods.length - 1 ? 12 : 0,
              ),
              child: _buildPaymentTile(methods[index], index),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentTile(_PaymentMethod method, int index) {
    final selected = _selectedPayment == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            // Icon box
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(method.icon, color: _primary, size: 20),
            ),
            const SizedBox(width: 16),
            // Labels
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    method.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            // Custom Radio
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? _primary : const Color(0xFFCBD5E1),
                  width: 2,
                ),
                color: selected ? _primary : Colors.white,
              ),
              child: selected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.white,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ── Order Summary ────────────────────────────────────────────────────────────

  Widget _buildOrderSummarySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Subtotal (3 items)', '₹345.00'),
                const SizedBox(height: 12),
                _buildSummaryRow('Taxes & Charges', '₹24.50'),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFE2E8F0), height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const Text(
                      '₹369.50',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: _brandRed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ── Bottom Bar ───────────────────────────────────────────────────────────────

  Widget _buildBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _brandRed,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            shadowColor: _brandRed.withValues(alpha: 0.25),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pay Now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Data Model ───────────────────────────────────────────────────────────────

class _PaymentMethod {
  final IconData icon;
  final String title;
  final String subtitle;

  _PaymentMethod({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
