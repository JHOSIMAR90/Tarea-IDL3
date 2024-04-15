import 'package:flutter/material.dart';



class OrderProduct extends StatelessWidget {
  const OrderProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: const Text(
          'Mi tienda',
          style: TextStyle(
            fontFamily: 'Madimi One',
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 15.0,
              ),
              width: MediaQuery.of(context).size.width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Datos de Contacto',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                      fontFamily: 'Madimi One',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Elegir Metodo de Pago'),
                      const DropdownMenuExample(),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText:
                              'Nombres del Cliente', // Texto que aparece sobre el campo de entrada
                          hintText:
                              'Escriba aquí', // Texto que aparece cuando el campo está vacío
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText:
                              'Telefono de Cliente', // Texto que aparece sobre el campo de entrada
                          hintText:
                              'Escriba aquí', // Texto que aparece cuando el campo está vacío
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderProduct()),
                          );
                        },
                        child: const Text("Enviar Pedido"),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

const List<String> list = <String>['cash', 'credit-card', 'debit-card'];

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
