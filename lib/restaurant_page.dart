import 'package:flutter/material.dart';
import 'restaurant_detail_page.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final List<Map<String, dynamic>> _restaurantes = [
    {
      'nombre': 'delpartido',
      'ciudad': 'Bogotá',
      'tipo': 'Comida Rápida',
      'descripcion': 'Hamburguesas artesanales',
      'puntos': 8.5,
      'imagen': 'assets/delpartido.jpg'
    },
    {
      'nombre': 'Sabores Paisas',
      'ciudad': 'Medellín',
      'tipo': 'Gourmet',
      'descripcion': 'Alta cocina colombiana',
      'puntos': 9.5,
      'imagen': 'assets/sabores_paisas.jpg'
    },
    {
      'nombre': 'San Isidro',
      'ciudad': 'Tunja',
      'tipo': 'Boyacense',
      'descripcion': 'La mejor comida de Boyacá',
      'puntos': 7.0,
      'imagen': 'assets/san_isidro.jpg'
    },
    {
      'nombre': 'Restaurante Cucuta',
      'ciudad': 'Cúcuta',
      'tipo': 'Típica',
      'descripcion': 'Mejores platos de los Santanderes',
      'puntos': 9.9,
      'imagen': 'assets/cucuta.jpg'
    },
  ];

  String _busqueda = '';
  String? _ciudadSeleccionada;
  String? _tipoSeleccionado;
  double _puntosMaximos = 10.0;

  @override
  Widget build(BuildContext context) {
    final ciudades = _restaurantes.map((r) => r['ciudad'] as String).toSet().toList();
    final tipos = _restaurantes.map((r) => r['tipo'] as String).toSet().toList();

    final List<Map<String, dynamic>> restaurantesFiltrados = _restaurantes.where((r) {
      final coincideNombre = r['nombre'].toLowerCase().contains(_busqueda.toLowerCase());
      final coincideCiudad = _ciudadSeleccionada == null || r['ciudad'] == _ciudadSeleccionada;
      final coincideTipo = _tipoSeleccionado == null || r['tipo'] == _tipoSeleccionado;
      final coincidePuntos = r['puntos'] <= _puntosMaximos;
      return coincideNombre && coincideCiudad && coincideTipo && coincidePuntos;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Restaurantes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _busqueda = value;
                });
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Ciudad'),
                  value: _ciudadSeleccionada,
                  items: ciudades.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (value) {
                    setState(() {
                      _ciudadSeleccionada = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Tipo de comida'),
                  value: _tipoSeleccionado,
                  items: tipos.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (value) {
                    setState(() {
                      _tipoSeleccionado = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Text('Puntos:'),
                Expanded(
                  child: Slider(
                    value: _puntosMaximos,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: _puntosMaximos.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _puntosMaximos = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: restaurantesFiltrados.length,
              itemBuilder: (context, index) {
                final r = restaurantesFiltrados[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailPage(
                          nombre: r['nombre']!,
                          ciudad: r['ciudad']!,
                          tipoComida: r['tipo']!,
                          descripcion: r['descripcion']!,
                          puntos: r['puntos']!,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.asset(
                            r['imagen'],
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r['nombre'],
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ciudad: ${r['ciudad']}'),
                                  Text('Puntos: ${r['puntos']}'),
                                ],
                              ),
                              Text('Tipo de Comida: ${r['tipo']}'),
                              Text('Descripción: ${r['descripcion']}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}