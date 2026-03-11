import 'package:flutter/material.dart';

class CartScreenApp extends StatelessWidget {
  const CartScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo - Your Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEC5B13)),
      ),
      home: const CartScreen(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kPrimary = Color(0xFFEC5B13);
const Color kBackground = Color(0xFFF8F6F6);

// ─── Cart Item Model ──────────────────────────────────────────────────────────

class CartItem {
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

// ─── Cart Screen ──────────────────────────────────────────────────────────────

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _items = [
    CartItem(
      name: 'Double Burger',
      price: 8.50,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBuqXl0vcS_Xa1WY6b--EBgGHlq5MQJz8LPzoC1kyxa99H84EQwtosDbbWwEWNoEZD7cnPI520RvpQRs9N6-Fged0AK1llNFIMMnEM_M56kVdIT4jWDS4zvCxikaGYpJt7BNFZPXHlfvnEkZbZHvqjXZlnnxoa3ZKWdu5AdiORvRoNWKDccPufkQSHaUl8XNZIvxdTOyEH3ilTG1WcdsTSmansCoZe63r5DqcM2ZOcaUIJc7OAPiraPk05YrkGJHO4jEYCYMUHGDM4Q',
    ),
    CartItem(
      name: 'Caesar Salad',
      price: 7.25,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAVC1B3YWmzS8YWAgl69uUBITYP8_KeJdcn7WmytzMh476Iqu02AfNRVv0e5e2XUAYVkKsspKzaFZ0UfxPW3jd1FXqcTLQVhe2qm1gajEgTxUl7dj9iiemjXXnSJABOB86hzFq4QqVSSW02Izs7ciNarcg8qpeJhjHsvWhpgwAfpchKrZhl6RERRkRWcXYNExUlJK4zYhMJYMpCmQPc6Av3BP6WWRN9iuzKYtRtz2YnVsFm5X_JpmwUxLH1xbexuiAc9lGhhoqFi6lA',
    ),
  ];

  static const double _deliveryFee = 1.50;
  static const double _serviceTax = 0.75;

  double get _subtotal =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get _total => _subtotal + _deliveryFee + _serviceTax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          // ── Sticky Top App Bar ──
          _buildAppBar(),

          // ── Scrollable content ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Delivery location
                  _buildDeliveryLocation(),
                  const SizedBox(height: 16),

                  // Cart items
                  ...List.generate(
                    _items.length,
                    (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildCartItem(i),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Promo code
                  _buildPromoCode(),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // ── Bottom Order Summary + CTA ──
          _buildOrderSummary(),
        ],
      ),
    );
  }

  // ── App Bar ────────────────────────────────────────────────────────────────

  Widget _buildAppBar() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Back button left
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF0F172A),
                      size: 22,
                    ),
                  ),
                ),
              ),
              // Title center
              const Text(
                'Your Cart',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Delivery Location ──────────────────────────────────────────────────────

  Widget _buildDeliveryLocation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.location_on, color: kPrimary, size: 22),
          ),
          const SizedBox(width: 12),
          // Text
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deliver to',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Canteen Counter A, Floor 2',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Cart Item Card ─────────────────────────────────────────────────────────

  Widget _buildCartItem(int index) {
    final item = _items[index];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Food image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child: const Icon(Icons.fastfood, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Name + price + controls
          Expanded(
            child: SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Name + delete
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: kPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Delete button
                      GestureDetector(
                        onTap: () => setState(() => _items.removeAt(index)),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Color(0xFF94A3B8),
                          size: 22,
                        ),
                      ),
                    ],
                  ),

                  // Quantity controls
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            // Minus
                            GestureDetector(
                              onTap: () {
                                if (item.quantity > 1) {
                                  setState(() => item.quantity--);
                                }
                              },
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color(0xFFE2E8F0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.04),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.remove,
                                    size: 14,
                                    color: Color(0xFF334155)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 16,
                              child: Text(
                                '${item.quantity}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Plus
                            GestureDetector(
                              onTap: () =>
                                  setState(() => item.quantity++),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color(0xFFE2E8F0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.04),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.add,
                                    size: 14,
                                    color: Color(0xFF334155)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Promo Code ─────────────────────────────────────────────────────────────

  Widget _buildPromoCode() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.confirmation_number_outlined,
              color: Color(0xFF94A3B8), size: 22),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Apply Promo Code',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF475569),
              ),
            ),
          ),
          const Icon(Icons.chevron_right,
              color: Color(0xFF94A3B8), size: 22),
        ],
      ),
    );
  }

  // ── Order Summary + Checkout ───────────────────────────────────────────────

  Widget _buildOrderSummary() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.fromLTRB(
        24,
        20,
        24,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Subtotal
          _summaryRow('Subtotal', '\$${_subtotal.toStringAsFixed(2)}',
              bold: false),
          const SizedBox(height: 8),
          // Delivery Fee
          _summaryRow('Delivery Fee',
              '\$${_deliveryFee.toStringAsFixed(2)}',
              bold: false),
          const SizedBox(height: 8),
          // Service Tax
          _summaryRow('Service Tax',
              '\$${_serviceTax.toStringAsFixed(2)}',
              bold: false),

          // Divider
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFFF1F5F9), height: 1),
          ),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '\$${_total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: kPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Proceed to Pay button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const SizedBox.shrink(),
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Proceed to Pay',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: kPrimary.withValues(alpha: 0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {required bool bold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            color: const Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}