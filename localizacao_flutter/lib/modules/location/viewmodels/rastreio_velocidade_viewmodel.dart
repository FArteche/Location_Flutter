import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localizacao_flutter/modules/location/models/localizacao_model.dart';
import 'package:permission_handler/permission_handler.dart';

class RastreioVelocidadeViewmodel with ChangeNotifier {
  LocalizacaoModel _localizacaoModel = LocalizacaoModel(
    velocidade: 0.0,
    distancia: 0.0,
    statusPermissao: 'Solicitando permissão',
  );
  Position? _ultimaPosicao;
  bool _estaRastreando = false;

  LocalizacaoModel get localizacao => _localizacaoModel;

  RastreioVelocidadeViewmodel() {
    _verificarPermissaoLocalizacao();
  }

  Future<void> _verificarPermissaoLocalizacao() async {
    final status = await Permission.location.request();
    _atualizarStatusPermissao(status.isGranted ? 'Permitido' : 'Negado');
    if (status.isGranted) {
      _iniciarRastreamento();
    }
  }

  void _atualizarStatusPermissao(String status) {
    _localizacaoModel = _localizacaoModel.copyWith(statusPermissao: status);
    notifyListeners();
  }

  void _iniciarRastreamento() {
    if (_estaRastreando) return;
    _estaRastreando = true;
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 5,
      ),
    ).listen((Position posicao) {
      final novaVelocidade = posicao.speed * 3.6;
      double distanciaIncremento = 0.0;

      if (_ultimaPosicao != null) {
        distanciaIncremento = Geolocator.distanceBetween(
              _ultimaPosicao!.latitude,
              _ultimaPosicao!.longitude,
              posicao.latitude,
              posicao.longitude,
            ) /
            1000;
      }

      _localizacaoModel = _localizacaoModel.copyWith(
        velocidade: novaVelocidade >= 0 ? novaVelocidade: 0.0,
        distancia: _localizacaoModel.distancia + distanciaIncremento,
      );
      _ultimaPosicao = posicao;
      notifyListeners();
    });
  }

  void resetarDados(){
    _localizacaoModel = localizacao.copyWith(
      velocidade: 0.0,
      distancia: 0.0,
    );
    _ultimaPosicao = null;
    notifyListeners();
  }
}
