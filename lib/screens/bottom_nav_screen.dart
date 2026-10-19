import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/section_card.dart';

/// Latihan 3 — Bottom navigation untuk beralih antar tab.
///
/// Setiap item di [BottomNavigationBar] menampilkan halaman berbeda.
/// State halaman (misalnya counter) **dipertahankan** saat beralih tab
/// karena kita pakai `IndexedStack` — bukan `Navigator.pop` yang menghancurkan
/// halaman sebelumnya.
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  static const routeName = '/bottom-nav';

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  static const _pages = <Widget>[_HomePage(), _SearchPage(), _ProfilePage()];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        indicatorColor: AppTheme.primary.withValues(alpha: 0.12),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Cari',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        children: [
          const SectionCard(
            title: 'Coba ini',
            child: Text(
              'Tekan tombol tambah beberapa kali, lalu pindah ke tab Cari '
              'dan kembali lagi. Angkanya tetap sama karena halaman ini '
              'tidak dibuang dari tree.',
              style: TextStyle(height: 1.5),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          SectionCard(
            title: 'Counter lokal',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_counter',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
                Row(
                  children: [
                    IconButton.filledTonal(
                      onPressed: () => setState(() => _counter--),
                      icon: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: AppTheme.spaceSm),
                    IconButton.filled(
                      onPressed: () => setState(() => _counter++),
                      icon: const Icon(Icons.add),
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
}

class _SearchPage extends StatelessWidget {
  const _SearchPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari')),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        children: const [
          SectionCard(
            title: 'Cari',
            child: Text(
              'Halaman ini bersih — tidak ada state lokal. Cocok untuk '
              'form pencarian nanti.',
              style: TextStyle(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        children: const [
          SectionCard(
            title: 'Profil',
            child: Text(
              'Ganti tab di bawah untuk melihat state Beranda tetap '
              'terjaga berkat IndexedStack.',
              style: TextStyle(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
