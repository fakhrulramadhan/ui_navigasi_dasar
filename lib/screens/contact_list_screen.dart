import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../theme/app_theme.dart';
import 'contact_detail_screen.dart';

/// Latihan 1 — Daftar kontak. Ketuk item untuk pindah ke halaman detail
/// dengan `Navigator.push` dan kirim objek [Contact] lewat constructor.
class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  static const routeName = '/contacts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kontak')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        itemCount: demoContacts.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppTheme.spaceSm),
        itemBuilder: (context, index) {
          final contact = demoContacts[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primary.withValues(alpha: 0.12),
                foregroundColor: AppTheme.primary,
                child: Text(contact.name[0]),
              ),
              title: Text(contact.name),
              subtitle: Text(contact.city),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Cara 1: kirim data lewat constructor (paling sederhana).
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ContactDetailScreen(contact: contact),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
