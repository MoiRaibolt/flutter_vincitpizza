import 'package:flutter_vincipizza/models/produto_tamanho.dart';

class Produto {
  int? id;
  String? descricao;
  String? categoria;
  String? ingredientes;
  String? imagem;
  List<ProdutoTamanho>? tamanhos;

  Produto(
      {this.id,
      this.descricao,
      this.categoria,
      this.imagem,
      this.ingredientes,
      this.tamanhos});

  factory Produto.fromJson(Map<String, dynamic> json) {
    var dynamicTamanhoList = json["tamanhos"] as List;
    var tamanhoList = dynamicTamanhoList
        .map((value) => ProdutoTamanho.fromJson(value))
        .toList();

    return Produto(
        id: json['id'],
        descricao: json['descricao'],
        categoria: json['categoria'],
        imagem: json['imagem'],
        ingredientes: json['ingredientes'],
        tamanhos: tamanhoList);
  }
}
