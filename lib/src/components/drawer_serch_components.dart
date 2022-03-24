import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:fullieapp/src/utils/preferences_utils.dart';
import 'dart:math' as math;

class DrawerSearch extends StatefulWidget {
  const DrawerSearch({Key? key}) : super(key: key);

  @override
  State<DrawerSearch> createState() => _DrawerSearchState();
}

class _DrawerSearchState extends State<DrawerSearch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  bool isInstitucionesShow = false;

  @override
  void initState() {
    super.initState();
    _getDataForInitState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  Future<void> _getDataForInitState() async {
    await PreferencesUtils.init();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: ClipRRect(
        child: Drawer(
          backgroundColor: Colors.grey[200],
          child: Container(
            height: size.height,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    DrawerHeader(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Mostrar todo",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Switch(
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                value: true,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Insituciones",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      trailing: Transform.rotate(
                        angle: isInstitucionesShow
                            ? 180 * math.pi / 180
                            : 0 * math.pi / 180,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () async {
                            if (animationController.status ==
                                    AnimationStatus.forward ||
                                animationController.status ==
                                    AnimationStatus.completed) {
                              animationController.reverse();

                              await Future.delayed(
                                const Duration(milliseconds: 300),
                              );

                              setState(() {
                                isInstitucionesShow = false;
                              });
                            } else {
                              animationController.forward();

                              setState(() {
                                isInstitucionesShow = true;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: !isInstitucionesShow,
                      child: CircularRevealAnimation(
                        animation: animation,
                        minRadius: 12,
                        maxRadius: 400,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.medical_services,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  "SEGURIDAD SOCIAL",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.medication_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  "INSTTIUCIONES PUBLICAS",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.medical_services_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  "IMSS",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.lightbulb,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  "SALUD MENTAL",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.add_shopping_cart,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  "FARMACIA",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.baby_changing_station,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  "GUARDERIAS ESPECIALES",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.local_hospital,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  "HOSPITAL GENERAL",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Insituciones",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      trailing: Transform.rotate(
                        angle: isInstitucionesShow
                            ? 180 * math.pi / 180
                            : 0 * math.pi / 180,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () async {},
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
