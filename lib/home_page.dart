import 'dart:convert';

import 'package:deposito/src/controllers/home_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final rua = TextEditingController();
  final bloco = TextEditingController();
  final nivel = TextEditingController();
  final apartamento = TextEditingController();
  final ean = TextEditingController();
  final desci = TextEditingController();

  HomeControler home = HomeControler();

  @override
  void dispose() {
    super.dispose();
    rua.dispose();
    bloco.dispose();
    nivel.dispose();
    apartamento.dispose();
    ean.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deposito"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon:const  Icon(Icons.qr_code_scanner), onPressed: scanQR),
            const Spacer(flex: 1),
            IconButton(icon: const Icon(Icons.barcode_reader), onPressed: scanBarcodeNormal),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: rua,
                      decoration: const InputDecoration(
                        label: Text('Rua'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: bloco,
                      decoration: const InputDecoration(
                        label: Text('bloco'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: nivel,
                      decoration: const InputDecoration(
                        label: Text('Nivel'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: apartamento,
                      decoration: const InputDecoration(
                        label: Text('Apartamento'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: desci,
                decoration: const InputDecoration(
                  label: Text('Descrição'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: ean,
                decoration: const InputDecoration(
                  label: Text('Code de Barras'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Quantidade'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Validade'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: null, child: Text('Registrar'),),
            ],
          ),
        ),
      ),
    );
  }

  /// barcode*/
  String _scanBarcode = 'Unknown';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    await mostraDesc();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    converterQrcodeEmJson();
  }

  mostraDesc() async {
    if (_scanBarcode != 'Unknown') {
        barcodeProduto(_scanBarcode);
        var teste = await home.mostrarDescicao(_scanBarcode);
        setState(() {
          desci.text = teste;
        });
    } else {}
  }

  converterQrcodeEmJson() {
    if (_scanBarcode != 'Unknown') {
      Map<String, dynamic> map = jsonDecode(_scanBarcode);
      setState(() {
        rua.text = map['rua'].toString();
        apartamento.text = map['apartamento'].toString();
        bloco.text = map['bloco'].toString();
        nivel.text = map['nivel'].toString();
      });

    }
  }

  void barcodeProduto(var barras) {
    setState(() {
      ean.text = barras;
    });
  }
}
