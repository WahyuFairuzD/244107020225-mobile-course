# Week 5 — Local Storage & Offline-First

## Identitas

Nama: Wahyu Fairuz Daniswara  
NIM: 244107020225  
Program Studi: D4 Teknik Informatika  
Institusi: Politeknik Negeri Malang  

## Deskripsi

Pada Week 5, praktikum membahas penggunaan local storage dan konsep offline-first pada aplikasi Flutter.

Aplikasi yang dibuat adalah **Offline Notes**, yaitu aplikasi sederhana untuk menyimpan catatan secara lokal menggunakan SQLite.

## Teknologi

- Flutter & Dart
- Riverpod
- SQLite / sqflite
- SharedPreferences
- sqflite_common_ffi
- Flutter Test

## Fitur

- Menampilkan daftar notes
- Menambahkan notes
- Menghapus notes
- Menyimpan notes ke SQLite
- Menyimpan pengaturan theme
- Light mode dan dark mode
- Dirty state untuk data yang belum tersinkronisasi
- Sinkronisasi data lokal
- Testing

## Implementasi

### 1. SQLite

SQLite digunakan sebagai database lokal untuk menyimpan data notes.

Data yang disimpan terdiri dari:

- `id`
- `title`
- `body`
- `updated_at`
- `dirty`

### 2. Repository

`NoteRepository` digunakan untuk mengatur proses akses data ke database, seperti:

- `getAll()`
- `insert()`
- `update()`
- `delete()`
- `getDirtyNotes()`
- `markAllSynced()`\

### 3. Riverpod

Riverpod digunakan untuk mengatur state notes dan menghubungkan data dari repository dengan UI.

### 4. Offline-First

Data notes disimpan terlebih dahulu ke database lokal sehingga aplikasi tetap dapat digunakan tanpa koneksi internet.

Note yang baru dibuat memiliki status `dirty`. Setelah proses synchronization berhasil, status tersebut diubah menjadi `synced`.

### 5. SharedPreferences

SharedPreferences digunakan untuk menyimpan pilihan theme aplikasi agar pengaturan tetap tersimpan ketika aplikasi dibuka kembali.

### 6. Testing

Testing dilakukan untuk memastikan fitur synchronization dan aplikasi dapat berjalan sesuai dengan yang diharapkan.

Untuk testing SQLite pada desktop digunakan `sqflite_common_ffi`.

## Kesimpulan

Pada praktikum Week 5 berhasil diterapkan local storage menggunakan SQLite, state management dengan Riverpod, penyimpanan preference menggunakan SharedPreferences, serta konsep offline-first dan synchronization pada aplikasi Flutter.