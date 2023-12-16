//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kutuphane__otomasyon/firestone_islemler.dart';
import 'package:kutuphane__otomasyon/kitap_card.dart';
import 'package:kutuphane__otomasyon/kitap_ekle.dart';

class KitapListesi extends StatefulWidget {
  const KitapListesi({Key? key});

  @override
  State<KitapListesi> createState() => _KitapListesiState();
}

class _KitapListesiState extends State<KitapListesi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mahsun Kalkan 02230201005",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirestoreIslemler().kitapGetir(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<Map<String, dynamic>> kitaplar = snapshot.data ?? [];

          return ListView.builder(
            itemCount: kitaplar.length,
            itemBuilder: (context, index) {
              String kitapAdi = kitaplar[index]['kitapAdi'];
              String yazarBilgisi =
                  'Yazar: ${kitaplar[index]['yazarlar'] ?? ''}, Sayfa Sayısı: ${kitaplar[index]['sayfaSayisi'] ?? ''}';

              return KitapCard(
                title: kitapAdi,
                subtitle: yazarBilgisi,
                documentId: kitaplar[index]['documentId'],
                onDelete: () {
                  // Silme işlemi tamamlandığında bu callback fonksiyonu çağırarak Card'ı silebiliriz.
                  setState(() {
                    kitaplar.removeAt(index);
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => KitapEkle(
                      documentId: '',
                    )),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Kitaplar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Satın Al',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
        selectedItemColor: Colors.purple,
        onTap: (index) {
          // İlgili sekmeye tıklanınca yapılacak işlemleri buraya ekleyebilirsiniz.
        },
      ),
    );
  }
}
