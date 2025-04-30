class LocalizacaoModel {
  final double velocidade;
  final double distancia;
  final String statusPermissao;

  LocalizacaoModel(
      {required this.velocidade,
      required this.distancia,
      required this.statusPermissao});

  LocalizacaoModel copyWith(
    {
    double? velocidade,
    double? distancia,
    String? statusPermissao,
  }) 
  {
    return LocalizacaoModel(
      velocidade: velocidade ?? this.velocidade,
      distancia: distancia ?? this.distancia,
      statusPermissao: statusPermissao ?? this.statusPermissao,
    );
  }
}
