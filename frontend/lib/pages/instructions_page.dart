import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instrucciones"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Title(
                color: Colors.black,
                child: const Text("¿Cómo utilizar la aplicación?"),
              ),
              const Text(
                  "La aplicación utiliza el sensor del giroscopio, por lo que si tu dispositivo móvil no cuenta con esta característica, se te informará de la limitante."),
              const Text("""
Es posible hacer 3 gestos:
- Izquierda: Al mover el telefono de forma vertical hacia la izquierda, este abrirá la página web de Youtube en tu computadora
- Derecha: Al mover el telefono de forma vertical hacia la derecha, este abrirá una hoja de excel en tu computadora
- Hacia al frente: Al mover el telefono hacia el frente, el sistema abrirá la página de whatsapp web en tu computadora, esta opción está desactivada por defecto pero puedes activarla en la misma pantalla donde accederás a los otros gestos
""")
            ],
          ),
        ),
      ),
    );
  }
}
