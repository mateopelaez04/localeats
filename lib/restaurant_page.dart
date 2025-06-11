import 'package:flutter/material.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  void _showCoupon(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cupón del Restaurante'),
        content: Image.asset(
          'assets/images/coupon_qr.png',
          fit: BoxFit.contain,
        ),
        actions: [
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurante')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.qr_code),
          label: const Text('Ver Cupón'),
          onPressed: () => _showCoupon(context),
        ),
      ),
    );
  }
}