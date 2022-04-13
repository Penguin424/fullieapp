import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/components/card_institcion_inicio_component.dart';
import 'package:fullieapp/src/providers/global_provider.dart';
import 'package:fullieapp/src/utils/web_platform.dart';

class PageViewHome extends ConsumerWidget {
  const PageViewHome({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerG = ref.read(globalProvider);
    return Material(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width,
            height: size.height * 0.03,
            child: const Text(
              'Mejores Instituciones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: size.height * 0.32,
            width: size.width,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: !(kIsWeb && detectMovil()) ? 1 : 0.6,
                initialPage: 0,
              ),
              itemBuilder: (cotext, index) {
                final institucion = providerG.instituciones[index];

                return CardInsitucionInicio(
                  size: size,
                  institucion: institucion,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/instituciones/detalle',
                    );
                  },
                );
              },
              itemCount: providerG.instituciones.length,
            ),
          ),
        ],
      ),
    );
  }
}
