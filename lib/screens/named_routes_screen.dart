import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/section_card.dart';

/// Data paket yang dikirim lewat named route sebagai arguments.
class PlanOption {
  const PlanOption({
    required this.id,
    required this.name,
    required this.price,
    required this.note,
  });

  final String id;
  final String name;
  final String price;
  final String note;
}

const demoPlans = <PlanOption>[
  PlanOption(
    id: 'basic',
    name: 'Basic',
    price: 'Rp 0',
    note: 'Untuk mencoba semua fitur dasar.',
  ),
  PlanOption(
    id: 'pro',
    name: 'Pro',
    price: 'Rp 49.000',
    note: 'Termasuk laporan bulanan dan ekspor data.',
  ),
  PlanOption(
    id: 'bisnis',
    name: 'Bisnis',
    price: 'Rp 149.000',
    note: 'Multi pengguna, hak akses, dan dukungan prioritas.',
  ),
];

/// Latihan 2 — Pindah halaman lewat named route.
///
/// Bedanya dengan `Navigator.push` biasa: nama route didaftarkan sekali di
/// `MaterialApp.routes`, lalu halaman mana pun bisa memanggilnya hanya dengan
/// string. Data tetap dikirim lewat `arguments`.
class NamedRoutesScreen extends StatelessWidget {
  const NamedRoutesScreen({super.key});

  static const routeName = '/named-routes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Named Routes')),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        children: [
          const SectionCard(
            title: 'Cara kerja',
            child: Text(
              'Setiap paket di bawah dibuka lewat nama route yang sama, '
              'yaitu PlanDetailScreen.routeName. Yang berbeda hanya '
              'arguments yang dikirim.',
              style: TextStyle(color: AppTheme.textSecondary, height: 1.5),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          ...demoPlans.map(
            (plan) => Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
              child: Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.workspace_premium_outlined,
                    color: AppTheme.primary,
                  ),
                  title: Text(plan.name),
                  subtitle: Text(plan.price),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(PlanDetailScreen.routeName, arguments: plan);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Halaman tujuan yang membaca arguments dari named route.
class PlanDetailScreen extends StatelessWidget {
  const PlanDetailScreen({super.key});

  static const routeName = '/named-routes/detail';

  @override
  Widget build(BuildContext context) {
    // arguments bertipe Object?, jadi perlu dicek sebelum dipakai.
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is! PlanOption) {
      return Scaffold(
        appBar: AppBar(title: const Text('Paket tidak ditemukan')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.spaceLg),
            child: Text(
              'Halaman ini harus dibuka dengan arguments berisi PlanOption.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(args.name)),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        children: [
          SectionCard(
            title: 'Ringkasan Paket',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args.price,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceSm),
                Text(
                  args.note,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          SectionCard(
            title: 'Arguments yang diterima',
            child: Text(
              'id: ${args.id}\n'
              'name: ${args.name}\n'
              'price: ${args.price}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kembali'),
          ),
        ],
      ),
    );
  }
}
