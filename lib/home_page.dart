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
        actions: [
          IconButton(
              onPressed: scanBarcodeNormal,
              icon: const Icon(Icons.barcode_reader)),
        ],
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
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: desci,
                      decoration: const InputDecoration(
                        label: Text('Descrição'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: scanBarcodeNormal,
                        icon: const Icon(Icons.barcode_reader),
                        color: Colors.greenAccent,
                      ))
                ],
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
                  label: Text('Valiade'),
                  border: OutlineInputBorder(),
                ),
              ),
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

  mostraDesc() async {
    if (_scanBarcode != 'Unknown') {
      if (_scanBarcode.length == 8) {
        barcodeDeposito(_scanBarcode);
      }
      if (_scanBarcode.length >= 9) {
        barcodeProduto(_scanBarcode);
        var teste = await home.mostrarDescicao(_scanBarcode);
        setState(() {
          desci.text = teste;
        });
      }
    } else {}
  }

  void barcodeDeposito(var barra) {
    var rua1 = _scanBarcode[0];
    var bloco1 = _scanBarcode[1];
    var nivel1 = _scanBarcode[2];
    var ap1 = _scanBarcode[3];

    setState(() {
      rua.text = rua1;
      bloco.text = bloco1;
      nivel.text = nivel1;
      apartamento.text = ap1;
    });
  }

  void barcodeProduto(var barras) {
    setState(() {
      ean.text = barras;
    });
  }
}
