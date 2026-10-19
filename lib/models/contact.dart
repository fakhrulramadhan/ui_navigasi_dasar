/// Data kontak. Model sederhana tanpa JSON karena materi ini fokus
/// pada navigasi, bukan parsing data.
class Contact {
  const Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.city,
    required this.note,
  });

  final int id;
  final String name;
  final String phone;
  final String email;
  final String city;
  final String note;
}

/// Daftar kontak contoh yang dipakai di beberapa halaman.
const demoContacts = <Contact>[
  Contact(
    id: 1,
    name: 'Siti Rahma',
    phone: '0812-3456-7890',
    email: 'siti.rahma@example.com',
    city: 'Jakarta',
    note: 'Rekan kerja di tim desain. Suka diskusi lewat pesan singkat.',
  ),
  Contact(
    id: 2,
    name: 'Budi Santoso',
    phone: '0813-9876-5432',
    email: 'budi.santoso@example.com',
    city: 'Bandung',
    note: 'Klien dari proyek sebelumnya. Waktu terbaik dihubungi pagi.',
  ),
  Contact(
    id: 3,
    name: 'Ayu Lestari',
    phone: '0821-1122-3344',
    email: 'ayu.lestari@example.com',
    city: 'Surabaya',
    note: 'Mentor komunitas Flutter daerah. Bisa diminta review kode.',
  ),
  Contact(
    id: 4,
    name: 'Rizky Pratama',
    phone: '0857-5566-7788',
    email: 'rizky.pratama@example.com',
    city: 'Yogyakarta',
    note: 'Teman kuliah. Sekarang bekerja di bagian backend.',
  ),
];
