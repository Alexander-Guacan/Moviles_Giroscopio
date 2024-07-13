import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú Principal"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/gyroscope"),
              child: const Text("Iniciar"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/instructions"),
              child: const Text("Instrucciones"),
            )
          ],
        ),
      ),
    );
  }
}
