import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inventory_screenXX.dart';
import 'push_architecture.dart';
import '../providers/user_provider.dart';
import '/services/bar_inventario.dart'; // ✅ Importamos la barra

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<UserProvider>(context).user;

    print(appUser?.username);     // email
    print(appUser?.tenantid);   // idbusiness

    return Scaffold(
      appBar: BarInventario.buildAppBar(context, widget.title), // ✅ Usamos BarInventario
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Has presionado el botón $_counter veces'),
            ElevatedButton(
              onPressed: () {
                if (appUser != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InventoryScreenXX(),
                    ),
                  );
                } else {
                  debugPrint("Usuario no cargado aún");
                }
              },
              child: const Text("Ver inventario"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WsTestClient(
                      apiGatewayUrl:
                      "wss://2hhwqrov1k.execute-api.us-east-2.amazonaws.com/production/",
                    ),
                  ),
                );
              },
              child: const Text("Test WebSocket"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}