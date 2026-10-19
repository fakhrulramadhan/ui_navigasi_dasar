import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_navigasi_dasar/main.dart';
import 'package:ui_navigasi_dasar/screens/bottom_nav_screen.dart';
import 'package:ui_navigasi_dasar/screens/contact_list_screen.dart';

void main() {
  testWidgets('menu utama menampilkan empat latihan', (tester) async {
    await tester.pumpWidget(const UiNavigasiApp());

    expect(find.text('Navigasi & Routing Flutter'), findsOneWidget);
    expect(find.textContaining('Kirim Data'), findsOneWidget);
    expect(find.textContaining('Named Routes'), findsOneWidget);
    expect(find.textContaining('Bottom Navigation'), findsOneWidget);
    expect(find.textContaining('Kembalikan Data'), findsOneWidget);
  });

  testWidgets('mengetuk latihan pertama membuka daftar kontak', (tester) async {
    await tester.pumpWidget(const UiNavigasiApp());

    await tester.tap(find.textContaining('Kirim Data'));
    await tester.pumpAndSettle();

    expect(find.byType(ContactListScreen), findsOneWidget);
    expect(find.text('Daftar Kontak'), findsOneWidget);
  });

  testWidgets('mengetuk kontak membuka halaman detail', (tester) async {
    await tester.pumpWidget(const UiNavigasiApp());

    await tester.tap(find.textContaining('Kirim Data'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Siti Rahma'));
    await tester.pumpAndSettle();

    expect(find.text('Detail Kontak'), findsOneWidget);
    expect(find.text('0812-3456-7890'), findsOneWidget);
  });

  testWidgets('state counter di Beranda tetap ada saat pindah tab', (
    tester,
  ) async {
    await tester.pumpWidget(const UiNavigasiApp());

    await tester.tap(find.textContaining('Bottom Navigation'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomNavScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('Cari'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
  });
}
