import 'package:flutter/material.dart';

void main() {
  runApp(const AdminMenuManagementApp());
}

class AdminMenuManagementApp extends StatelessWidget {
  const AdminMenuManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo Admin - Menu Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC6102E)),
        fontFamily: 'sans-serif',
      ),
      home: const AdminMenuManagementScreen(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kPrimary = Color(0xFFC6102E);
const Color kBackground = Color(0xFFF8F6F6);

// ─── Models ──────────────────────────────────────────────────────────────────

class MenuItem {
  final String name;
  final String price;
  final String category;
  final String description;
  final String imageUrl;
  final bool available;

  const MenuItem({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.available,
  });
}

const List<MenuItem> kMenuItems = [
  MenuItem(
    name: 'Classic Burger',
    price: r'$8.50',
    category: 'Meals',
    description: 'Premium beef patty',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDIIV7dHxFlQR6qpGMqGfITSLkx_-ackHkg70lEN4jRzKhmoIIAb3wAWOh5ecKn9-i_FcxBPEyLMVfhb9a340nGFNm5TTbCPFo8KrFPivVmitOcSk-02UzFvVWebGX0yNcal7YN8fRpTuORccIw_TmW2nDRPQjXVjCgPm8bhPQ9d-V0p3R-JsGkfALWrxjcR92NCEQ4Bk_VoB-4Oh-Jn51L4WLvuvmJcXK5wBVuWVjYCZYpFz7niOb7pFQd7Po_7TfRIax9LS5d5Szv',
    available: true,
  ),
  MenuItem(
    name: 'Garden Salad',
    price: r'$7.50',
    category: 'Meals',
    description: 'Fresh seasonal greens',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDz5gsMwWpWrwzmfrNS6w-QSJJfvjpnFyT4_XR-x20iKnI4rF3K81bV27H8MumGEJM4jOLfLbHa6Io2TajhGMjq7IKEHuVOgE9A1Wy4NzW7JaKGq5PQEQ0IhbJIBJjKbL5sVuJFWM1FcBz3j4EzSFNe7NKP3p2Md2VcYYHjxjCKHPY2HB2K4BTXk8zrLwfKZ6_J2BbXq9NZpnRd2tDk5kHYa43qf9pqRVnTHYlXGIAj4JfCZFvqK3N7-smqr3BU-szgf9KUGR0E',
    available: false,
  ),
  MenuItem(
    name: 'Iced Coffee',
    price: r'$4.00',
    category: 'Beverages',
    description: 'Cold brew',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBMC-7UtNmj0cIqz35JfBgSb0h3OgkNZPYx2-ORumIJ_vQb3mj1xhb3iK3V5hJ-aakRuvicx_5CGyCxnWb7c3b1jLFjP2gCT9Ev2i6hQ0k0LS-KYqf_Hqx0f3KCGMUTcyoJxuTmJ0A60bHYdIpSJL-xTjUzR7R3QHZkDlQ7aL3-qM-SfCR_hCJGi7LUW2e1HEeeBs3E94JbdgNSuRuBBl4y3PU8G3QnlE8ZPCikP9mJR9nQG95zcRMwxAtflT8KoiCUXVdlKX9Pg',
    available: true,
  ),
  MenuItem(
    name: 'French Fries',
    price: r'$3.50',
    category: 'Snacks',
    description: 'Salted & crispy',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBb4W1ixLSGYSbsJoGmpVWf8wXfCrMFKT05xQFk0Q4hJTK-GzjzjCM5NJBHwVL4PL_kqVk7dyjgUC5CfI0L2O7V9wSdNxvBj_q7I5V2FqhYsixK-6N5X-3S3YIHFTRhFdXE8UkUMjvH6XpX9TGlVEPSjF1U8G_jqb0Ks2Qd5XxHr3OQ4aaLHlxfVGK4iKADWB40Kl7V_MOVeFRz7yLfmQHVjGHwSHG8HKqPRKUBEwYJa8KjxcV-YvlhAtc_gNK5gzEdEMWKMRc',
    available: true,
  ),
  MenuItem(
    name: 'Pasta Alfredo',
    price: r'$9.00',
    category: 'Meals',
    description: 'Fettuccine pasta',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCBxjUBUDkKNUo2nHfzfH3wB7VxrDd1V0B0FqBXVJb-EFg0BzxW2XGfbPuBxXVr4Q_fXGLxkzIJEFQqFjMMT2F9Pzjm6Rn1XH0bIPNqMCiGq_Rq8HOUjrWxFHPrn7bpUTMIrXd5KY4kDwJY3VVi1vO3cDRkEzRsj1fzHzZ3a9JImb6sC0HPEdQ-tCjcHqwZtYbJaEXX-YZV-7PMeTwjU_g8qWLw8nTm-7kNxiQkHKNTB4zJL4nP8Ck9NBKK2RqKBJ6XNQK5bGRw',
    available: true,
  ),
  MenuItem(
    name: 'Fruit Bowl',
    price: r'$5.00',
    category: 'Desserts',
    description: 'Fresh cut fruits',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAvNn2NrGqJwexKrmEmGf_FmeDQeJ_gUU8mI4pyVf6Q6JUsydotdFSM0VIA06MvczXYIA8Rh-eOtmjrMXDEJClldmPN294LpvEPSt2-b09U8M2k0JuQCKhkSMoVVuWM0rpzDeYo0OdiP9o0GF3f5e7Oi6Wxn1meW_WMLAZhMegbNigV71XNsYxeUUHHWKVwxoyENf4wLgnrKvKdZHlyoWMzRbYSELlWVhNQcjnX3WhimmNewyYcJEE1xIlmOSxdO_Uw4aVHKO51A5wU',
    available: true,
  ),
  MenuItem(
    name: 'Club Sandwich',
    price: r'$7.00',
    category: 'Meals',
    description: 'Triple decker',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCGELEboWG6gpj7TTa9_pALCXiFyewQ685PJGuiU8zd2bofFBeIAmD2gKK7-wTYZ0PTKQhhakL5gkV5ZKeJY4UMQ0UDu74J-NtnIHSv8g_dVVBWCeMiC8OTXVWIikm4xq5fL8ebkjtRH2a4leBTb8sAzZhMC-frSfCNEOrfRhqx8PDv3a5oLSPdwP5-wfphYGZZKSgaZEyC7I7nF-d7dnsvMG2F2Ga8hvGivTvBvPhryqFeKngpIQPFlAPtZvHbGqnLoi282E9XnSg3',
    available: false,
  ),
];

const List<String> kCategories = [
  'All Items',
  'Snacks',
  'Meals',
  'Beverages',
  'Desserts',
  'Combos',
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class AdminMenuManagementScreen extends StatefulWidget {
  const AdminMenuManagementScreen({super.key});

  @override
  State<AdminMenuManagementScreen> createState() =>
      _AdminMenuManagementScreenState();
}

class _AdminMenuManagementScreenState
    extends State<AdminMenuManagementScreen> {
  int _selectedCategory = 0;
  int _selectedPage = 1;

  // Local toggle states
  late List<bool> _toggleStates;

  @override
  void initState() {
    super.initState();
    _toggleStates = kMenuItems.map((m) => m.available).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(48, 32, 48, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPageHeader(),
                        const SizedBox(height: 28),
                        _buildCategoryFilters(),
                        const SizedBox(height: 24),
                        _buildGrid(),
                        const SizedBox(height: 40),
                        _buildPagination(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Top Bar ───────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
      decoration: BoxDecoration(
        // FIX: replaced .withValues(alpha:) with .withOpacity()
        color: Colors.white.withValues(alpha: 0.92),
        border: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.close,
                    color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                  children: [
                    TextSpan(text: 'CanteenGo '),
                    TextSpan(
                      text: 'Admin',
                      style: TextStyle(color: kPrimary),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(width: 40),

          // Nav links
          Row(
            children: [
              const _NavLink(label: 'Dashboard', active: false),
              const SizedBox(width: 24),
              const _NavLink(label: 'Orders', active: false),
              const SizedBox(width: 24),
              const _NavLink(label: 'Menu', active: true),
              const SizedBox(width: 24),
              const _NavLink(label: 'Users', active: false),
            ],
          ),

          const Spacer(),

          // Search bar
          Container(
            width: 220,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Row(
              children: [
                SizedBox(width: 12),
                Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search menu items...',
                      hintStyle: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Icons
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF475569), size: 22),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined,
                color: Color(0xFF475569), size: 22),
          ),
          const SizedBox(width: 4),

          // Avatar
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // FIX: replaced .withValues(alpha:) with .withOpacity()
              color: kPrimary.withValues(alpha: 0.1),
              border: Border.all(
                  color: kPrimary.withValues(alpha: 0.2), width: 1.5),
            ),
            child: ClipOval(
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAN2Sh6Ej5cWlLnDPFod6dgc3XcraNyPGCoT57_NhNhtkLwnCu2nogP3JeRdnL7hPyCLkODlz5FDlEagBx8HC70IKdh0ar1MN7GyvIgm5utPFoG6HC-lTFlf7mfHY90fZLWYo1BLCxDj_bb031VBgKVl2v2Z77HIR4NpMhIcb9zsEbsv2mrsVCUzF9PoE-QUR3qNx3vwioF-D5Ar-JpCq5qKwnXngRB-f5BPu-r4qUK4dWczfF4AmtQrGh61Ka5RIZlx72DqvagOpp-',
                fit: BoxFit.cover,
                // FIX: errorBuilder parameters must be uniquely named
                errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person_outline,
                    color: Color(0xFF94A3B8),
                    size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Page Header ───────────────────────────────────────────────────────────

  Widget _buildPageHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Menu Management',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Add, edit, and organize your canteen offerings.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
          label: const Text(
            'Add New Item',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            elevation: 4,
            // FIX: replaced .withValues(alpha:) with .withOpacity()
            shadowColor: kPrimary.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }

  // ── Category Filters ──────────────────────────────────────────────────────

  Widget _buildCategoryFilters() {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(kCategories.length, (i) {
                final isActive = i == _selectedCategory;
                return Padding(
                  padding: EdgeInsets.only(
                      right: i < kCategories.length - 1 ? 10 : 0),
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _selectedCategory = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive ? kPrimary : Colors.white,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isActive
                              ? kPrimary
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        kCategories[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isActive
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
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {},
          child: const Row(
            children: [
              Icon(Icons.filter_list,
                  size: 18, color: Color(0xFF64748B)),
              SizedBox(width: 6),
              Text(
                'More Filters',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Grid ──────────────────────────────────────────────────────────────────

  Widget _buildGrid() {
    return LayoutBuilder(builder: (context, constraints) {
      const cols = 4;
      const spacing = 20.0;
      final cardWidth =
          (constraints.maxWidth - spacing * (cols - 1)) / cols;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          // 7 menu item cards
          ...List.generate(kMenuItems.length, (i) {
            return SizedBox(
              width: cardWidth,
              child: _MenuItemCard(
                item: kMenuItems[i],
                available: _toggleStates[i],
                onToggle: (val) =>
                    setState(() => _toggleStates[i] = val),
              ),
            );
          }),
          // Quick Add placeholder
          SizedBox(
            width: cardWidth,
            height: 340,
            child: _QuickAddCard(),
          ),
        ],
      );
    });
  }

  // ── Pagination ────────────────────────────────────────────────────────────

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                  fontSize: 13, color: Color(0xFF64748B)),
              children: [
                TextSpan(text: 'Showing '),
                TextSpan(
                  text: '7',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                TextSpan(text: ' of '),
                TextSpan(
                  text: '42',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                TextSpan(text: ' items'),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              _PageBtn(label: 'Previous', onTap: () {}),
              const SizedBox(width: 6),
              _PageNumBtn(
                  number: 1,
                  active: _selectedPage == 1,
                  onTap: () => setState(() => _selectedPage = 1)),
              const SizedBox(width: 6),
              _PageNumBtn(
                  number: 2,
                  active: _selectedPage == 2,
                  onTap: () => setState(() => _selectedPage = 2)),
              const SizedBox(width: 6),
              _PageBtn(label: 'Next', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }

  // ── Footer ────────────────────────────────────────────────────────────────

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          const Text(
            '© 2024 CanteenGo Admin Portal. All rights reserved.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF94A3B8),
            ),
          ),
          const Spacer(),
          const Row(
            children: [
              _FooterLink(label: 'Help Center'),
              SizedBox(width: 24),
              _FooterLink(label: 'API Documentation'),
              SizedBox(width: 24),
              _FooterLink(label: 'Terms'),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Menu Item Card ───────────────────────────────────────────────────────────

class _MenuItemCard extends StatefulWidget {
  final MenuItem item;
  final bool available;
  final ValueChanged<bool> onToggle;

  const _MenuItemCard({
    required this.item,
    required this.available,
    required this.onToggle,
  });

  @override
  State<_MenuItemCard> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<_MenuItemCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    // FIX: replaced .withValues(alpha:) with .withOpacity()
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    // FIX: replaced .withValues(alpha:) with .withOpacity()
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
              child: SizedBox(
                height: 170,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.item.imageUrl,
                      fit: BoxFit.cover,
                      // FIX: errorBuilder parameters must be uniquely named
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFE2E8F0),
                        child: const Icon(Icons.fastfood,
                            color: Colors.grey, size: 40),
                      ),
                    ),
                    // Status badge
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.available
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          widget.available
                              ? 'AVAILABLE'
                              : 'OUT OF STOCK',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: widget.available
                                ? const Color(0xFF15803D)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Info section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: _hovered
                                ? kPrimary
                                : const Color(0xFF0F172A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        widget.item.price,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: kPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.item.category} • ${widget.item.description}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Color(0xFFF1F5F9))),
                    ),
                    child: Row(
                      children: [
                        // STATUS toggle
                        Row(
                          children: [
                            const Text(
                              'STATUS',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF94A3B8),
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () =>
                                  widget.onToggle(!widget.available),
                              child: _Toggle(on: widget.available),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Edit icon
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.edit_outlined,
                                size: 18,
                                color: Color(0xFF94A3B8)),
                          ),
                        ),
                        // More icon
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            child: const Icon(Icons.more_vert,
                                size: 18,
                                color: Color(0xFF94A3B8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Toggle Widget ────────────────────────────────────────────────────────────

class _Toggle extends StatelessWidget {
  final bool on;
  const _Toggle({required this.on});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 36,
      height: 20,
      decoration: BoxDecoration(
        color: on ? kPrimary : const Color(0xFFCBD5E1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: on ? 17 : 2,
            top: 2,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Quick Add Card ───────────────────────────────────────────────────────────

class _QuickAddCard extends StatefulWidget {
  @override
  State<_QuickAddCard> createState() => _QuickAddCardState();
}

class _QuickAddCardState extends State<_QuickAddCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            // FIX: replaced .withValues(alpha:) with .withOpacity()
            color: _hovered
                ? kPrimary.withValues(alpha: 0.4)
                : const Color(0xFFCBD5E1),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                // FIX: replaced .withValues(alpha:) with .withOpacity()
                color: _hovered
                    ? kPrimary.withValues(alpha: 0.08)
                    : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_circle_outline,
                size: 28,
                color: _hovered ? kPrimary : const Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 14),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color:
                    _hovered ? kPrimary : const Color(0xFF64748B),
              ),
              child: const Text('Quick Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Nav Link ─────────────────────────────────────────────────────────────────

class _NavLink extends StatelessWidget {
  final String label;
  final bool active;
  const _NavLink({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? kPrimary : const Color(0xFF475569),
          ),
        ),
        if (active) ...[
          const SizedBox(height: 2),
          Container(
            height: 2,
            width: 24,
            color: kPrimary,
          ),
        ],
      ],
    );
  }
}

// ─── Pagination Helpers ───────────────────────────────────────────────────────

class _PageBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PageBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF334155),
          ),
        ),
      ),
    );
  }
}

class _PageNumBtn extends StatelessWidget {
  final int number;
  final bool active;
  final VoidCallback onTap;
  const _PageNumBtn(
      {required this.number,
      required this.active,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          // FIX: replaced .withValues(alpha:) with .withOpacity()
          color: active ? kPrimary.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: active ? kPrimary : const Color(0xFF475569),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Footer Link ──────────────────────────────────────────────────────────────

class _FooterLink extends StatelessWidget {
  final String label;
  const _FooterLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF94A3B8),
        ),
      ),
    );
  }
}