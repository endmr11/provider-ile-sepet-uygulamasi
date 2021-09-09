import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

class SepetData with ChangeNotifier {
  String? urunAdi;
  String? urunFiyati;
  var eklenenUrunAdi = [];
  var eklenenFiyati = [];

  void sepeteEkle(String gelenUrunAdi, String gelenUrunFiyati) {
    eklenenUrunAdi.add(gelenUrunAdi);
    eklenenFiyati.add(gelenUrunFiyati);
    print("Ürün adı: $eklenenUrunAdi, Ürün Fiyatı: $eklenenFiyati");
    notifyListeners();
  }
}

/*
    ChangeNotifierProvider<SepetData>(
      create: (BuildContext context) => SepetData(),
      child: MyApp(),
    ),*/
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SepetData>(
          create: (BuildContext context) => SepetData(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var urunler = [
    ['Araba', '10000'],
    ['Bilgisayar', '300'],
    ['Ayakkabı', '100'],
    ['Terlik', '15'],
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hepsiburada",
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: Badge(
                position: BadgePosition.topEnd(top: 0, end: 3),
                animationDuration: Duration(milliseconds: 300),
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(
                  Provider.of<SepetData>(context)
                      .eklenenUrunAdi
                      .length
                      .toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    icon: Icon(Icons.shopping_cart), onPressed: () {}),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: urunler.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      Provider.of<SepetData>(context, listen: false)
                          .sepeteEkle(urunler[index][0], urunler[index][1]);
                    },
                    leading: Icon(
                      Icons.list_alt_outlined,
                      size: 40.0,
                      color: Colors.black,
                    ),
                    title: Text(
                      urunler[index][0],
                    ),
                    trailing: Text(
                      urunler[index][1] + " TL",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
