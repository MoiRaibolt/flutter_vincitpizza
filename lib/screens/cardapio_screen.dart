import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vincipizza/models/pedido.dart';
import 'package:flutter_vincipizza/models/pedido_item.dart';
import 'package:flutter_vincipizza/models/produto.dart';
import 'package:flutter_vincipizza/models/produto_tamanho.dart';
import 'package:flutter_vincipizza/navbar.dart';
import 'package:flutter_vincipizza/screens/pedido_screen.dart';
import 'package:intl/intl.dart';

class CardapioScreen extends StatefulWidget {
  const CardapioScreen({super.key});

  @override
  State<CardapioScreen> createState() => _CardapioScreen();
}

class _CardapioScreen extends State<CardapioScreen> {
  bool carrinhoVisible = false;
  List<Produto> produtos = [];
  Pedido pedido = Pedido(itens: []);
  final oCcy = NumberFormat("#,##0.00", "pt_BR");

  @override
  Widget build(BuildContext context) {
    carregarProdutos().then((value) {
      setState(() {
        produtos = value;
      });
    });

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(150, 0, 0, 0),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Center(
              child: Text(
            "Cardápio",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                  icon: Icon(
                Icons.local_pizza,
                color: Colors.white,
              )),
              Tab(
                  icon: Icon(
                Icons.local_drink,
                color: Colors.white,
              )),
              Tab(
                  icon: Icon(
                Icons.icecream,
                color: Colors.white,
              )),
            ],
          ),
        ),
        drawer: const Navbar(),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top +
                      kToolbarHeight +
                      kTextTabBarHeight),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover),
              ),
              child: buildCardapio(),
            ),
            buildCarrinho(),
            buildCarrinhoFinalizar(),
          ],
        ),
      ),
    );
  }

/*Cardápio ----------------------------------------------------------*/
  Widget buildCardapio() {
    return TabBarView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: produtos
                .where((produto) => produto.categoria == "pizza")
                .map((produto) => buildCardapioItem(produto))
                .toList(),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: produtos
                .where((produto) => produto.categoria == "bebida")
                .map((produto) => buildCardapioItem(produto))
                .toList(),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: produtos
                .where((produto) => produto.categoria == "sobremesa")
                .map((produto) => buildCardapioItem(produto))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildCardapioItem(Produto produto) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(100, 0, 0, 0),
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10)),
        height: 100,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 5, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image:
                        AssetImage("assets/images/cardapio/${produto.imagem}"),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 5, top: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.descricao!,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      produto.ingredientes!,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  var tamanhoAsync = retornarTamanho(context, produto);

                  tamanhoAsync.then((tamanho) {
                    if (tamanho != null) {
                      var pedidoItem = PedidoItem(
                          produto: produto,
                          produtoTamanho: tamanho,
                          quantidade: 1,
                          total: tamanho.valor);

                      setState(() => pedido.itens!.add(pedidoItem));
                    }
                  });
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      )),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/* Carrinho ----------------------------------------------------------*/
  Widget buildCarrinhoFinalizar() {
    return Visibility(
      visible: pedido.itens!.isNotEmpty && !carrinhoVisible,
      child: GestureDetector(
        onTap: () {
          setState(() => carrinhoVisible = true);
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(230, 0, 0, 0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          height: 50,
          child: const Center(
              child: Text(
            "Finalizar Pedido",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
      ),
    );
  }

  Widget buildCarrinho() {
    return Visibility(
      visible: pedido.itens!.isNotEmpty && carrinhoVisible,
      child: Container(
        height: 400,
        decoration: const BoxDecoration(
          color: Color.fromARGB(230, 0, 0, 0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: pedido.itens!
                        .map((pedidoItem) => buildCarrinhoItem(pedidoItem))
                        .toList(),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(width: 5))),
                      child: FloatingActionButton(
                        heroTag: "cardapio.adicionarmaisitens",
                        onPressed: () {
                          setState(() => carrinhoVisible = false);
                        },
                        backgroundColor: Color(0xff8B0000),
                        child: const Text(
                          "Adicionar Mais Itens",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(width: 5))),
                      child: FloatingActionButton(
                        heroTag: "cardapio.finalizarpedido",
                        backgroundColor: Colors.green,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PedidoScreen(),
                              settings: RouteSettings(
                                arguments: pedido,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Finalizar Pedido",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCarrinhoItem(PedidoItem pedidoItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          pedidoItem.produto!.descricao!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            pedidoItem.produtoTamanho!.descricao!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Qtde.: ${pedidoItem.quantidade}",
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    int qtde = pedidoItem.quantidade! + 1;
                    double valor = pedidoItem.produtoTamanho!.valor!;
                    double total = qtde * valor;

                    pedidoItem.quantidade = qtde;
                    pedidoItem.total = total;
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    int qtde = pedidoItem.quantidade! - 1;

                    if (qtde > 0) {
                      double valor = pedidoItem.produtoTamanho!.valor!;
                      double total = qtde * valor;

                      pedidoItem.quantidade = qtde;
                      pedidoItem.total = total;
                    } else {
                      pedido.itens!.remove(pedidoItem);

                      if (pedido.itens!.isEmpty) {
                        carrinhoVisible = false;
                      }
                    }
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Produto>> carregarProdutos() async {
    String jsonString =
        await rootBundle.loadString("assets/data/produtos.json");

    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Produto> result =
        jsonList.map((json) => Produto.fromJson(json)).toList();

    return result;
  }

  Future<ProdutoTamanho?> retornarTamanho(
      BuildContext context, Produto produto) async {
    List<ProdutoTamanho> tamanhos = produto.tamanhos!;

    ProdutoTamanho? result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(225, 0, 0, 0),
          title: Text(
            produto.descricao!,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            "Escolha um tamanho",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: tamanhos.map((tamanho) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SizedBox(
                width: double.infinity,
                child: FloatingActionButton(
                  heroTag: "cardapio.tamanho.${tamanho.descricao}",
                  onPressed: () {
                    Navigator.of(context).pop(tamanho);
                  },
                  child: Text(
                    "${tamanho.descricao} (R\$ ${oCcy.format(tamanho.valor)})",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );

    return result;
  }
}
