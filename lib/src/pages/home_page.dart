import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/components/drawer_info_perfil_component.dart';
import 'package:fullieapp/src/components/drawer_serch_components.dart';
import 'package:fullieapp/src/components/pageview_home_component.dart';
import 'package:fullieapp/src/providers/global_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
          Column(
            children: [
              SizedBox(
                height: size.height * 0.65,
                child: providerG.isMapReady
                    ? GoogleMap(
                        initialCameraPosition: providerG.cameraPosition,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        markers: providerG.markers,
                        onMapCreated: (controller) {
                          providerG.mapController = controller;
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              PageViewHome(
                size: size,
              ),
            ],
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
                    icon: const Icon(Icons.medical_services),
                    onPressed: () {
                      Navigator.pushNamed(context, '/instituciones');
                    },
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
