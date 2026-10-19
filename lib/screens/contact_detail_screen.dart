import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../theme/app_theme.dart';
import '../widgets/section_card.dart';

/// Halaman detail kontak.
///
/// Menerima satu objek [Contact] lewat constructor, lalu menampilkannya.
/// Tombol kembali mengembalikan nilai ke halaman sebelumnya.
class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kontak'),
        actions: [
          IconButton(
            onPressed: () => _showContactOptions(context),
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          children: [
            SectionCard(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: AppTheme.primary,
                    child: Icon(
                      Icons.person,
                      size: 36,
                      color: AppTheme.surface,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  Text(
                    contact.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceXs),
                  Text(
                    contact.phone,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spaceMd),
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Catatan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceXs),
                  Text(
                    contact.note,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _callContact(context),
                    icon: const Icon(Icons.call_outlined),
                    label: const Text('Telepon'),
                  ),
                ),
                const SizedBox(width: AppTheme.spaceMd),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _sendMessage(context),
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text('Kirim Pesan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _callContact(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Memanggil ${contact.name}...')));
  }

  void _sendMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Membuka percakapan dengan ${contact.name}')),
    );
  }

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.star_outline),
                title: const Text('Tandai sebagai favorit'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kontak ditandai')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Hapus kontak'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  Navigator.of(context).pop('deleted');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
