// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:proyecto_integrador_3/controllers/userController.dart';
import 'package:proyecto_integrador_3/user.dart';

class ListaUsuariosPage extends StatefulWidget {
  const ListaUsuariosPage({Key? key}) : super(key: key);

  @override
  _ListaUsuariosPageState createState() => _ListaUsuariosPageState();
}

class _ListaUsuariosPageState extends State<ListaUsuariosPage> {
  final ObtenerUsuarios _obtenerUsuarios = ObtenerUsuarios();
  final EliminarUsuario _eliminarUsuario = EliminarUsuario();

  Future<List<User>>? _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = _obtenerUsuarios.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<User> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('${user.name} ${user.lastname}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email),
                        const SizedBox(height: 4),
                        Text('Tipo: ${user.role}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await _eliminarUsuario.eliminarUsuario(user.email);

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Usuario eliminado.')));
                        setState(() {
                          _futureUsers = _obtenerUsuarios.getUsers();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}