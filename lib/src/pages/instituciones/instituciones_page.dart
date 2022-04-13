import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/providers/global_provider.dart';
import 'package:fullieapp/src/utils/web_platform.dart';

class InstitucionesPage extends ConsumerWidget {
  const InstitucionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerG = ref.watch(globalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instituciones'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: providerG.instituciones.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (kIsWeb && detectMovil()) ? 7 : 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final institucion = providerG.instituciones[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/instituciones/detalle',
                arguments: institucion,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://penguin424.me${institucion.imagen}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${institucion.institucion!}\n${institucion.distancia?.toStringAsFixed(2)} KM',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
