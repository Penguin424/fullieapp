import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/providers/register_provider.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final registerP = ref.watch(registerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // IconButton(
                //   icon: const Icon(
                //     Icons.arrow_back_ios_new,
                //     color: Colors.white,
                //   ),
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                // ),
                Center(
                  child: SizedBox(
                    width: size.width * 0.8,
                    height: size.height * 0.8,
                    child: PageView(
                      controller: registerP.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          height: size.height * 0.8,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'DATOS DEL USUARIO',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: size.height * 0.6,
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: registerP.formDatosUsuario,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Nombre completo',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              registerP.nombre = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Correo electrónico',
                                              border: OutlineInputBorder(),
                                            ),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onChanged: (value) {
                                              registerP.email = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              } else if (!value.contains('@')) {
                                                return 'Correo electrónico inválido';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Contraseña',
                                              border: OutlineInputBorder(),
                                            ),
                                            obscureText: true,
                                            onChanged: (value) {
                                              registerP.password = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Confirmar contraseña',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              registerP.passwordConfirm = value;
                                            },
                                            obscureText: true,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              }
                                              if (value != registerP.password) {
                                                return 'Las contraseñas no coinciden';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Teléfono',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              registerP.telefono = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.black,
                                    ),
                                    onPressed:
                                        registerP.handleChangeToDatosDireccion,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          height: size.height * 0.8,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'DATOS DE DIRECCIÓN',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: size.height * 0.6,
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: registerP.formDatosDireccion,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Dirección',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              registerP.direccion = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Colonia',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              registerP.colonia = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Código postal',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              registerP.codigoPostal = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Ciudad',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              registerP.ciudad = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Estado',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              registerP.estado = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Este campo es requerido';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      registerP.pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.black,
                                    ),
                                    onPressed:
                                        registerP.handleChangeToDatosPerfil,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          height: size.height * 0.8,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'PERFIL USUARIO',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: size.height * 0.6,
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 120,
                                          backgroundImage: registerP
                                                  .isImageChange
                                              ? MemoryImage(
                                                  registerP.imagenPerfilBytes,
                                                ) as ImageProvider
                                              : const AssetImage(
                                                  'assets/perfil.png',
                                                ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          '¿Quieres subir una foto de perfil?',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: registerP
                                                  .handleUpdateImageFromGallery,
                                              icon:
                                                  const Icon(Icons.photo_sharp),
                                              label: const Text('Galeria'),
                                            ),
                                            const SizedBox(width: 20),
                                            ElevatedButton.icon(
                                              onPressed: registerP
                                                  .handleUpdateImageFromCamera,
                                              icon:
                                                  const Icon(Icons.camera_alt),
                                              label: const Text('Camara'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      registerP.pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                  ),
                                  registerP.isLoading
                                      ? const CircularProgressIndicator()
                                      : IconButton(
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            registerP.handleSubmitRegister(
                                              context,
                                            );
                                          },
                                        )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
