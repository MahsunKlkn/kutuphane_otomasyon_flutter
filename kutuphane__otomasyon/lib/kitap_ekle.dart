import 'package:flutter/material.dart';
import 'package:kutuphane__otomasyon/firestone_islemler.dart';

class KitapEkle extends StatefulWidget {
  const KitapEkle({Key? key}) : super(key: key);

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
                  FirestoreIslemler().kitapEkle(
                      kitapAdi.text,
                      yayinEvi.text,
                      yazarlar.text,
                      kategori,
                      sayfaSayisi.text,
                      basimYili.text,
                      yayinlanacakmi);

                  kitapAdi.clear();
                  yayinEvi.clear();
                  yazarlar.clear();
                  sayfaSayisi.clear();
                  basimYili.clear();
                  Navigator.pop(context);
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
