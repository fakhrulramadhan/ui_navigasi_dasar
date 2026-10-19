import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Halaman cadangan saat nama route tidak dikenali.
///
/// Didaftarkan lewat `onUnknownRoute` di `MaterialApp`, jadi aplikasi tidak
/// crash ketika ada yang memanggil route yang salah.
class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.name;

    return Scaffold(
      appBar: AppBar(title: const Text('Halaman tidak ditemukan')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spaceLg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.explore_off_outlined,
                  size: 64,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(height: AppTheme.spaceMd),
                Text(
                  name == null
                      ? 'Route tidak dikenali.'
                      : 'Route "$name" belum terdaftar.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceLg),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
