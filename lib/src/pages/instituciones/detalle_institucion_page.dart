import 'package:flutter/material.dart';

class DetalleInstitucionPage extends StatelessWidget {
  const DetalleInstitucionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Institucion'),
      ),
      body: const Center(
        child: Text('Detalle Institucion'),
      ),
    );
  }
}
