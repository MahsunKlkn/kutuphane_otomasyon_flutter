import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreIslemler {
  final CollectionReference kitaplar =
      FirebaseFirestore.instance.collection('kitaplar');

  Future<void> kitapEkle(
      String kitapAdi,
      String yayinEvi,
      String yazarlar,
      String kategori,
      String sayfaSayisi,
      String basimYili,
      bool yayinlanacakMi) async {
    try {
      await kitaplar.add({
        'kitapAdi': kitapAdi,
        'yayinEvi': yayinEvi,
        'yazarlar': yazarlar,
        'kategori': kategori,
        'sayfaSayisi': int.parse(sayfaSayisi),
        'basimYili': int.parse(basimYili),
        'yayinlanacakMi': yayinlanacakMi,
      });
      print('Kitap başarıyla eklendi.');
    } catch (e) {
      print('Kitap eklenirken bir hata oluştu: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> kitapGetir() {
    return kitaplar.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'kitapAdi': doc['kitapAdi'] ?? '',
          'yazarlar': doc['yazarlar'] ?? '',
          'sayfaSayisi': doc['sayfaSayisi'] ?? 0,
        };
      }).toList();
    });
  }
}
