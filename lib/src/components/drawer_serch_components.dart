import 'package:flutter/material.dart';
import 'package:fullieapp/src/utils/preferences_utils.dart';

class DrawerSearch extends StatefulWidget {
  const DrawerSearch({Key? key}) : super(key: key);

  @override
  State<DrawerSearch> createState() => _DrawerSearchState();
}

class _DrawerSearchState extends State<DrawerSearch> {
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
