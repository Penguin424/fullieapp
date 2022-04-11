import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/components/card_institcion_inicio_component.dart';
import 'package:fullieapp/src/components/drawer_info_perfil_component.dart';
import 'package:fullieapp/src/components/drawer_serch_components.dart';
import 'package:fullieapp/src/providers/global_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerG = ref.watch(globalProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerSearch(),
      endDrawer: const DrawerInfo(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: !providerG.isListFocused
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.65,
                  child: providerG.isMapReady
                      ? GoogleMap(
                          initialCameraPosition: providerG.cameraPosition,
                          myLocationEnabled: true,
                          markers: providerG.markers,
                          onMapCreated: (controller) {
                            providerG.mapController = controller;
                          },
                          onTap: (value) {
                            _scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                            providerG.isListFocused = false;
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                Material(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  child: GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        size.height * 0.65,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                      providerG.isListFocused = true;
                    },
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
                              viewportFraction: !kIsWeb ? 1 : 0.6,
                              initialPage: 0,
                            ),
                            itemBuilder: (cotext, index) {
                              final institucion =
                                  providerG.instituciones[index];

                              return CardInsitucionInicio(
                                size: size,
                                institucion: institucion,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/detalle/institucion',
                                  );
                                },
                              );
                            },
                            itemCount: providerG.instituciones.length,
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          height: 20,
                          thickness: 2,
                        ),
                        ...providerG.instituciones
                            .map(
                              (institucion) => SizedBox(
                                height: size.height * 0.32,
                                width: size.width,
                                child: CardInsitucionInicio(
                                  size: size,
                                  institucion: institucion,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/detalle/institucion',
                                    );
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 55,
            left: 15,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ],
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address, city, state...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline),
                    onPressed: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
