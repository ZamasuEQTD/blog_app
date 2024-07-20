import 'package:blog_app/presentation/hilos/widgets/postear_hilo_form/portada.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/bloc/crear_hilo/crear_hilo_bloc.dart';


class PostearHiloView extends StatelessWidget {
  const PostearHiloView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CrearHiloBloc(),
      child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Crear hilo",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.arrow_left)),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Crear",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            body: const PostearHiloViewBody()),
    );
  }
}

class PostearHiloViewBody extends StatelessWidget {
  const PostearHiloViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: context.read(),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 5),
            PortadaDeHilo(),
            SizedBox(height: 5),
            SeleccionarSubcategoria(),
            SizedBox(height: 5),
            // ConfiguracionDeBanderas(),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class SeleccionarSubcategoria extends StatelessWidget {
  const SeleccionarSubcategoria({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () {},
        title: const Text("Gore"),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const SizedBox(
            height: 50,
            width: 50,
            child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696")),
          ),
        ),
      ),
    );
  }
}
