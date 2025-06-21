import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String nombre;
  final String ciudad;
  final String tipoComida;
  final String descripcion;
  final double puntos;

  const RestaurantDetailPage({
    super.key,
    required this.nombre,
    required this.ciudad,
    required this.tipoComida,
    required this.descripcion,
    required this.puntos,
  });

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool mostrarQR = false;
  final _comentarioController = TextEditingController();
  double _rating = 0;

  String get qrData => '''
Restaurante: ${widget.nombre}
Ciudad: ${widget.ciudad}
Puntos: ${widget.puntos}
''';

  Future<void> _abrirCartaPDF() async {
    final String assetPath = _obtenerRutaPDF(widget.nombre.toLowerCase());

    try {
      final ByteData data = await rootBundle.load(assetPath);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${widget.nombre}.pdf');
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
      OpenFile.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al abrir el PDF: $e')),
      );
    }
  }

  String _obtenerRutaPDF(String nombre) {
    switch (nombre) {
      case 'delpartido':
        return 'assets/delpartido.pdf';
      case 'sabores paisas':
        return 'assets/sabores_paisas.pdf';
      case 'san isidro':
        return 'assets/san_isidro.pdf';
      case 'restaurante cucuta':
        return 'assets/Cucuta.pdf';
      default:
        return 'assets/delpartido.pdf';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nombre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ciudad: ${widget.ciudad}'),
            Text('Tipo de Comida: ${widget.tipoComida}'),
            Text('Descripción: ${widget.descripcion}'),
            Text('Puntos: ${widget.puntos}'),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _abrirCartaPDF,
              child: const Text('Ver Carta en PDF'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  mostrarQR = true;
                });
              },
              child: const Text('Generar Cupón QR'),
            ),

            const SizedBox(height: 20),

            if (mostrarQR)
              Center(
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),

            const SizedBox(height: 30),
            const Text('Comentarios:', style: TextStyle(fontWeight: FontWeight.bold)),

            TextField(
              controller: _comentarioController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Escribe tu comentario aquí...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final comentario = _comentarioController.text;
                if (comentario.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Comentario enviado: $comentario')),
                  );
                  _comentarioController.clear();
                }
              },
              child: const Text('Enviar Comentario'),
            ),

            const SizedBox(height: 30),
            const Text('Califica este restaurante:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gracias por calificar con $rating estrellas.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}