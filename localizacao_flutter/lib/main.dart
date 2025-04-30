import 'package:flutter/material.dart';
import 'package:localizacao_flutter/modules/location/viewmodels/rastreio_velocidade_viewmodel.dart';
import 'package:localizacao_flutter/modules/location/views/rastreio_velocidade_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const RastreioVelocidadeApp());
}

class RastreioVelocidadeApp extends StatelessWidget {
  const RastreioVelocidadeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RastreioVelocidadeViewmodel(),
      child: MaterialApp(
        title: "Velocimentro e Hodômetro",
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const RastreioVelocidadeView(),
      ),
    );
  }
}
