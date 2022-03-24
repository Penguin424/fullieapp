import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fullieapp/src/components/drawer_info_perfil_component.dart';
import 'package:fullieapp/src/components/drawer_serch_components.dart';
import 'package:fullieapp/src/controllers/global_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final gController = Get.find<GloblalController>();
  bool isListfocused = false;
  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    gController.handleGetInitData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerSearch(),
      endDrawer: const DrawerInfo(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: !isListfocused
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.65,
                  child: Obx(
                    () => gController.isMapReady.value
                        ? GoogleMap(
                            zoomControlsEnabled: false,
                            onTap: (value) {
                              setState(() {
                                _scrollController.animateTo(
                                  0.0,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 300),
                                );
                                isListfocused = false;
                              });
                            },
                            initialCameraPosition:
                                gController.cameraPosition.value,
                            onMapCreated: (contoller) {
                              gController.mapController = contoller.obs;
                            },
                            markers: gController.markers,
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
                Obx(
                  () => Material(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.animateTo(
                            320.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                          isListfocused = true;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SizedBox(
                            height: size.height * 0.3,
                            width: size.width,
                            child: PageView.builder(
                              itemBuilder: (cotext, index) {
                                final institucion =
                                    gController.instituciones[index];

                                return Container(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  width: size.width * 0.3,
                                  height: size.height * 0.15,
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
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                          Container(
                                            width: size.width * 0.6,
                                            height: size.height * 0.15,
                                            // color: Colors.deepOrange,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RatingBar.builder(
                                                      itemSize: 22,
                                                      initialRating: 4,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (context, _) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        );
                                                      },
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                    const Text('Calidad'),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RatingBar.builder(
                                                      itemSize: 22,
                                                      initialRating: 3,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (context, _) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        );
                                                      },
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                    const Text('Tiempo'),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RatingBar.builder(
                                                      itemSize: 22,
                                                      initialRating: 2.5,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (context, _) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        );
                                                      },
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                        height: size.height * 0.04,
                                        child: PageView(
                                          controller: PageController(
                                            viewportFraction: 0.8,
                                            initialPage: 0,
                                          ),
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                              ),
                                              child: ElevatedButton.icon(
                                                onPressed: () {},
                                                icon:
                                                    const Icon(Icons.drive_eta),
                                                label:
                                                    const Text('Indicaciones'),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                              ),
                                              child: ElevatedButton.icon(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.list_alt_sharp),
                                                label: const Text('Cita'),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
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
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: gController.instituciones.length,
                            ),
                          ),
                          Container(
                            width: size.width * 0.3,
                            height: size.height * 0.15,
                          ),
                          Container(
                            width: size.width * 0.3,
                            height: size.height * 0.15,
                          ),
                          Container(
                            width: size.width * 0.3,
                            height: size.height * 0.15,
                          ),
                          Container(
                            width: size.width * 0.3,
                            height: size.height * 0.15,
                          ),
                          Container(
                            width: size.width * 0.3,
                            height: size.height * 0.15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 35,
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
