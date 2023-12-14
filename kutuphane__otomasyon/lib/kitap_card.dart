import 'package:flutter/material.dart';

class KitapCard extends StatefulWidget {
  const KitapCard({Key? key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

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
                // Edit ikonuna tıklanınca yapılacak işlemler
                print("Edit ikonuna tıklandı");
              },
              child: Icon(Icons.edit),
            ),
            SizedBox(width: 20.0),
            GestureDetector(
              onTap: () {
                // Delete ikonuna tıklanınca yapılacak işlemler
                print("Delete ikonuna tıklandı");
              },
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
