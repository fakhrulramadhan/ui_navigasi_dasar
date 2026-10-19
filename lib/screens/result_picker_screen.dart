import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/section_card.dart';

/// Latihan 4 — Mengembalikan data dari halaman yang ditutup.
///
/// `Navigator.push` mengembalikan `Future`. Nilai yang dikirim lewat
/// `Navigator.pop(context, nilai)` akan diterima di `await` pada halaman
/// pemanggil.
class ResultPickerScreen extends StatefulWidget {
  const ResultPickerScreen({super.key});

  static const routeName = '/result-picker';

  @override
  State<ResultPickerScreen> createState() => _ResultPickerScreenState();
}

class _ResultPickerScreenState extends State<ResultPickerScreen> {
  String? _selected;

  Future<void> _openPicker() async {
    // Hasil pop bertipe String?, jadi aman kalau halaman ditutup
    // tanpa memilih apa pun.
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const _OptionPickerPage()),
    );

    if (!mounted) return;

    if (result == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Tidak ada yang dipilih')));
      return;
    }

    setState(() => _selected = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kembalikan Data')),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        children: [
          const SectionCard(
            title: 'Cara kerja',
            child: Text(
              'Tekan tombol di bawah. Halaman pemilih akan terbuka dan '
              'menutup diri dengan membawa satu nilai. Nilai itu yang '
              'ditampilkan di sini.',
              style: TextStyle(height: 1.5, color: AppTheme.textSecondary),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          SectionCard(
            title: 'Nilai yang diterima',
            child: Text(
              _selected ?? 'Belum ada. Tekan tombol di bawah.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _selected == null
                    ? AppTheme.textSecondary
                    : AppTheme.primary,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spaceLg),
          FilledButton.icon(
            onPressed: _openPicker,
            icon: const Icon(Icons.list_alt_outlined),
            label: const Text('Pilih opsi'),
          ),
        ],
      ),
    );
  }
}

/// Halaman yang hanya bertugas memilih satu opsi lalu menutup diri
/// dengan membawa hasil.
class _OptionPickerPage extends StatelessWidget {
  const _OptionPickerPage();

  static const _options = <String>[
    'Prioritas rendah',
    'Prioritas normal',
    'Prioritas tinggi',
    'Mendesak',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Prioritas')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        itemCount: _options.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppTheme.spaceSm),
        itemBuilder: (context, index) {
          final option = _options[index];
          return Card(
            child: ListTile(
              title: Text(option),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).pop(option),
            ),
          );
        },
      ),
    );
  }
}
