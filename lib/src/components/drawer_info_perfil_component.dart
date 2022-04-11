import 'package:flutter/material.dart';
import 'package:fullieapp/src/utils/preferences_utils.dart';

class DrawerInfo extends StatefulWidget {
  const DrawerInfo({Key? key}) : super(key: key);

  @override
  State<DrawerInfo> createState() => _DrawerInfoState();
}

class _DrawerInfoState extends State<DrawerInfo> {
  @override
  void initState() {
    _getDataForInitState();
    super.initState();
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
                            children: [
                              Icon(
                                Icons.person_pin_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                PreferencesUtils.getString('userName'),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Favoritos",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      leading: Icon(
                        Icons.star_outline_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          ModalRoute.withName('/'),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Calendario",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      leading: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          ModalRoute.withName('/'),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Historial de consultas",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      leading: Icon(
                        Icons.medical_services_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          ModalRoute.withName('/'),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Promociones",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      leading: Icon(
                        Icons.local_offer_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          ModalRoute.withName('/'),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Ajustes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      leading: Icon(
                        Icons.settings,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/settings',
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Sporte",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      leading: Icon(
                        Icons.support_agent_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          ModalRoute.withName('/'),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Informacion",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      leading: Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          ModalRoute.withName('/'),
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    ListTile(
                      title: Text(
                        "Cerrar sesión",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        PreferencesUtils.putBool('isLogged', false);
                        PreferencesUtils.putString('jwt', '');
                        PreferencesUtils.putInteger('userId', 0);
                        PreferencesUtils.putString('userName', '');
                        PreferencesUtils.putString('user', '');
                        PreferencesUtils.putInteger('distancia', 10);

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          ModalRoute.withName('/'),
                        );
                      },
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
