import 'package:flutter/material.dart';
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
                  height: size.height * 0.9,
                  child: Obx(
                    () => gController.isMapReady.value
                        ? GoogleMap(
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
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
                GestureDetector(
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
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: size.height * 0.4,
                      minWidth: size.width,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [],
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
