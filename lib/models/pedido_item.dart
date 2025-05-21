import 'package:flutter_vincipizza/models/produto.dart';
import 'package:flutter_vincipizza/models/produto_tamanho.dart';

class PedidoItem {
  Produto? produto;
  ProdutoTamanho? produtoTamanho;
  int? quantidade;
  double? total;

  PedidoItem({
    this.produto,
    this.produtoTamanho,
    this.quantidade,
    this.total,
  });
}
