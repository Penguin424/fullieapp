import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fullieapp/src/models/institucion_distancia_model.dart';

class CardInsitucionInicio extends StatelessWidget {
  const CardInsitucionInicio({
    Key? key,
    required this.size,
    required this.institucion,
  }) : super(key: key);

  final Size size;
  final InstitucionDistanciaModel institucion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(
          10,
        ),
        width: size.width * 0.34,
        height: size.height * 0.2,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
            width: 3,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  child: Image.network(
                    'https://penguin424.me${institucion.imagen}',
                    fit: BoxFit.cover,
                    width: size.width * 0.3,
                    height: size.height * 0.15,
                  ),
                ),
                SizedBox(
                  width: !kIsWeb ? size.width * 0.55 : size.width * 0.25,
                  height: size.height * 0.15,
                  child: Column(
                    children: [
                      Text(
                        institucion.institucion!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            itemSize: 22,
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (rating) {
                              if (kDebugMode) {
                                print(rating);
                              }
                            },
                          ),
                          const Text('Calidad'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            itemSize: 22,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (rating) {
                              if (kDebugMode) {
                                print(rating);
                              }
                            },
                          ),
                          const Text('Tiempo'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            itemSize: 22,
                            initialRating: 2.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (rating) {
                              if (kDebugMode) {
                                print(rating);
                              }
                            },
                          ),
                          const Text('Precio'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Abierto',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text('Horarario 00:00am - 23:59pm'),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.03,
              child: PageView(
                controller: PageController(
                  viewportFraction: 0.8,
                  initialPage: 0,
                ),
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.drive_eta),
                      label: const Text('Indicaciones'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.list_alt_sharp),
                      label: const Text('Cita'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.phone),
                      label: const Text('Llamar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
