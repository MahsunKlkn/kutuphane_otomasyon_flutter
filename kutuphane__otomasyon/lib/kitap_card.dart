import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kutuphane__otomasyon/firestone_islemler.dart';
import 'package:kutuphane__otomasyon/kitap_ekle.dart';

class KitapCard extends StatefulWidget {
  const KitapCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.documentId,
    required this.onDelete,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String documentId;
  final Function onDelete;

  @override
  State<KitapCard> createState() => _KitapCardState();
}

class _KitapCardState extends State<KitapCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                print(widget.documentId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        KitapEkle(documentId: widget.documentId),
                  ),
                );
              },
              child: Icon(Icons.edit),
            ),
            SizedBox(width: 20.0),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              //Herhangi bir işlem yapılmasına gerek yok
                              Navigator.of(context).pop();
                            },
                            child: Text("Hayır")),
                        ElevatedButton(
                            onPressed: () {
                              _deleteKitap(widget.documentId);
                              Navigator.of(context).pop();
                            },
                            child: Text("Evet"))
                      ],
                      title: const Text("Silme İşlemi"),
                      contentPadding: const EdgeInsets.all(20.0),
                      content: const Text(
                          "Bu kitap kaydını silmek istediğinize eminmisiniz?")),
                );
              },
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteKitap(String documentId) async {
    try {
      await FirestoreIslemler().veriSil(documentId);
      widget.onDelete();
      print('Kitap başarıyla silindi.');
    } catch (e) {
      print('Hata oluştu: $e');
      // Handle the error (e.g., show a snackbar or alert dialog)
    }
  }
}
