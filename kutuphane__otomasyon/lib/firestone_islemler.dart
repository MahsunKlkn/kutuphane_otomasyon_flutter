import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreIslemler {
  final CollectionReference kitaplar =
      FirebaseFirestore.instance.collection('kitaplar');

  Stream<List<Map<String, dynamic>>> kitapGetir() {
    return kitaplar
        .where('yayinlanacakMi', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'documentId': doc.id,
          'kitapAdi': doc['kitapAdi'] ?? '',
          'yazarlar': doc['yazarlar'] ?? '',
          'sayfaSayisi': doc['sayfaSayisi'] ?? 0,
        };
      }).toList();
    });
  }

  Future<void> veriEklemeAdd({
    required String kitapAdi,
    required String yayinEvi,
    required String yazarlar,
    required String kategori,
    required String sayfaSayisi,
    required String basimYili,
    required bool yayinlanacakMi,
  }) async {
    Map<String, dynamic> _eklenecekUser = {
      'kitapAdi': kitapAdi,
      'yayinEvi': yayinEvi,
      'yazarlar': yazarlar,
      'kategori': kategori,
      'sayfaSayisi': int.parse(sayfaSayisi),
      'basimYili': int.parse(basimYili),
      'yayinlanacakMi': yayinlanacakMi,
    };

    await kitaplar.add(_eklenecekUser);
  }

  Future<void> veriGuncelleme({
    required String documentId,
    required String kitapAdi,
    required String yayinEvi,
    required String yazarlar,
    required String kategori,
    required String sayfaSayisi,
    required String basimYili,
    required bool yayinlanacakMi,
  }) async {
    if (documentId.isEmpty) {
      print('Error: DocumentId is empty.');
      return;
    }

    int parsedSayfaSayisi, parsedBasimYili;

    try {
      parsedSayfaSayisi = int.parse(sayfaSayisi);
      parsedBasimYili = int.parse(basimYili);
    } catch (e) {
      print('Error parsing strings to integers: $e');
      return;
    }

    await kitaplar.doc(documentId).update({
      'kitapAdi': kitapAdi,
      'yayinEvi': yayinEvi,
      'yazarlar': yazarlar,
      'kategori': kategori,
      'sayfaSayisi': parsedSayfaSayisi,
      'basimYili': parsedBasimYili,
      'yayinlanacakMi': yayinlanacakMi,
    });
  }

  Future<void> veriSil(String documentId) async {
    try {
      if (documentId.isNotEmpty) {
        await kitaplar.doc(documentId).delete();
        print('Kitap başarıyla silindi.');
      } else {
        print('Hata: Belge ID boş olamaz.');
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }
}
