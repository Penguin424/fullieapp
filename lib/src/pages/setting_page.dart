import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/providers/global_provider.dart';
import 'package:fullieapp/src/utils/preferences_utils.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  double _distancia = 10.0;

  @override
  void initState() {
    handleGetInitData();

    super.initState();
  }

  handleGetInitData() async {
    await PreferencesUtils.init();

    setState(() {
      _distancia = ref.read(globalProvider).distancia;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIGURACIONES'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'distancia de busqueda',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: _distancia,
                    min: 10.0,
                    max: 100,
                    divisions: 100,
                    label: '${_distancia.toInt()} km',
                    onChangeEnd: (value) {
                      final providerG = ref.read(globalProvider);

                      providerG.distancia = value;
                    },
                    onChanged: (double value) {
                      setState(() {
                        _distancia = value;
                        // providerG.distancia = value;
                      });
                    },
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
