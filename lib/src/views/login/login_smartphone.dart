import 'package:flutter/material.dart';

getLoginSmartphone(
    TextEditingController rua,
    TextEditingController bloco,
    TextEditingController nivel,
    TextEditingController apartamento,
    TextEditingController ean,
    TextEditingController desci,
    Function() scanBarcodeNormal) {
  return Padding(
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
              label: Text('Validade'),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    ),
  );
}
