import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizacao_flutter/modules/location/viewmodels/rastreio_velocidade_viewmodel.dart';

class RastreioVelocidadeView extends StatelessWidget {
  const RastreioVelocidadeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RastreioVelocidadeViewmodel>(context);
    final localizacao = viewModel.localizacao;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Velocímetro e Hodômetro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (localizacao.statusPermissao != "Permitido")
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Status da permissão: ${localizacao.statusPermissao}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
              ),
            Card(
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Velocidade Atual",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '${localizacao.velocidade.toStringAsFixed(1)} km/h',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Distância Percorrida',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '${localizacao.distancia.toStringAsFixed(3)} km',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: viewModel.resetarDados,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                "Resetar",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
