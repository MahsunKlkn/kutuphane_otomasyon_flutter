import 'package:flutter/material.dart';
import 'package:kutuphane__otomasyon/firestone_islemler.dart';

class KitapEkle extends StatefulWidget {
  const KitapEkle({Key? key, required this.documentId}) : super(key: key);

  final String documentId;

  @override
  _KitapEkleState createState() => _KitapEkleState();
}

class _KitapEkleState extends State<KitapEkle> {
  var kitapAdi = TextEditingController();
  var yayinEvi = TextEditingController();
  var yazarlar = TextEditingController();
  var kategori = "Roman";
  var sayfaSayisi = TextEditingController();
  var basimYili = TextEditingController();
  var yayinlanacakmi = false;

  @override
  void initState() {
    super.initState();

    // widget.documentId null değilse, mevcut veriyi yükle
    if (widget.documentId.isNotEmpty) {
      // Güncelleme işlemi
      FirestoreIslemler()
          .veriGuncelleme(
        documentId: widget.documentId,
        kitapAdi: kitapAdi.text,
        yayinEvi: yayinEvi.text,
        yazarlar: yazarlar.text,
        kategori: kategori,
        sayfaSayisi: sayfaSayisi.text,
        basimYili: basimYili.text,
        yayinlanacakMi: yayinlanacakmi,
      )
          .then((_) {
        print('Kitap başarıyla güncellendi.');
      }).catchError((error) {
        print('Hata oluştu: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgi = MediaQuery.of(context);
    final double ekranGenislik = ekranBilgi.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Kitap Ekle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: kitapAdi,
                decoration: InputDecoration(
                  hintText: "Kitap Adı",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: yayinEvi,
                decoration: InputDecoration(
                  hintText: "Yayın Evi",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: yazarlar,
                decoration: InputDecoration(
                  hintText: "Yazarlar",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: DropdownButtonFormField<String>(
                value: kategori,
                onChanged: (newValue) {
                  setState(() {
                    kategori = newValue!;
                  });
                },
                items: <String>[
                  'Roman',
                  'Tarih',
                  'Edebiyat',
                  'Şiir',
                  'Ansiklopedi',
                  'Diğer'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: sayfaSayisi,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Sayfa Sayısı",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: basimYili,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Basım Yılı",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Listede yayınlanacak mı?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Checkbox(
                      value: yayinlanacakmi,
                      onChanged: (value) {
                        setState(() {
                          yayinlanacakmi = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: ekranGenislik - 150),
              child: ElevatedButton(
                onPressed: () {
                  if (widget.documentId.isNotEmpty) {
                    // documentId mevcut ise güncelleme yap
                    FirestoreIslemler()
                        .veriGuncelleme(
                      documentId: widget.documentId,
                      kitapAdi: kitapAdi.text,
                      yayinEvi: yayinEvi.text,
                      yazarlar: yazarlar.text,
                      kategori: kategori,
                      sayfaSayisi: sayfaSayisi.text,
                      basimYili: basimYili.text,
                      yayinlanacakMi: yayinlanacakmi,
                    )
                        .then((_) {
                      print('Kitap başarıyla güncellendi.');

                      kitapAdi.clear();
                      yayinEvi.clear();
                      yazarlar.clear();
                      sayfaSayisi.clear();
                      basimYili.clear();
                    }).catchError((error) {
                      print('Hata oluştu: $error');
                    });
                    Navigator.pop(context);
                  } else {
                    // documentId yoksa yeni kitap ekle
                    FirestoreIslemler()
                        .veriEklemeAdd(
                      kitapAdi: kitapAdi.text,
                      yayinEvi: yayinEvi.text,
                      yazarlar: yazarlar.text,
                      kategori: kategori,
                      sayfaSayisi: sayfaSayisi.text,
                      basimYili: basimYili.text,
                      yayinlanacakMi: yayinlanacakmi,
                    )
                        .then((_) {
                      print('Kitap başarıyla eklendi.');

                      kitapAdi.clear();
                      yayinEvi.clear();
                      yazarlar.clear();
                      sayfaSayisi.clear();
                      basimYili.clear();
                    }).catchError((error) {
                      print('Hata oluştu: $error');
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text("Kaydet"),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(120, 50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
