import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vincipizza/models/pedido.dart';
import 'package:flutter_vincipizza/models/pedido_item.dart';
import 'package:flutter_vincipizza/models/produto.dart';
import 'package:flutter_vincipizza/navbar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PedidoScreen extends StatefulWidget {
  const PedidoScreen({super.key});

  @override
  State<PedidoScreen> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  Pedido? pedido;
  final oCcy = NumberFormat("#,##0.00", "pt_BR");

  @override
  Widget build(BuildContext context) {
    pedido = ModalRoute.of(context)!.settings.arguments as Pedido;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(100, 0, 0, 0),
        title: const Center(
          child: Text(
            "Pedido",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: const Navbar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: buildPedido(),
                ),
                Expanded(
                  flex: 4,
                  child: buildPedidoEntrega(),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton(
                      heroTag: "pedido.enviarpedido",
                      onPressed: () async {
                        await enviarPedidoWhatsapp();
                      },
                      backgroundColor: Colors.green,
                      child: const Text(
                        "Enviar Pedido",
                        style: TextStyle(color: Colors.white),
                      ),
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

  Widget buildPedido() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(200, 0, 0, 0),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: const Center(
              child: Text(
                "Itens do Pedido",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: pedido!.itens!
                      .map((item) => buildPedidoItem(item))
                      .toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 2))),
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Total: R\$ 65,90",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildPedidoItem(PedidoItem pedidoItem) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/cardapio/${pedidoItem.produto!.imagem}"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pedidoItem.produto!.descricao!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Tamanho: ${pedidoItem.produtoTamanho!.descricao}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Qtde.: ${pedidoItem.quantidade}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
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
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  oCcy.format(pedidoItem.total),
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPedidoEntrega() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromARGB(200, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text(
                  "Dados para Entrega",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            TextField(
              style: TextStyle(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                  label: Text(
                "CEP",
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    decoration: InputDecoration(
                        label: Text(
                      "Endereço",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    decoration: InputDecoration(
                        label: Text(
                      "Número",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                  ),
                ),
              ],
            ),
            TextField(
              style: TextStyle(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                  label: Text(
                "Bairro",
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Future enviarPedidoWhatsapp() async {
    String url = "https://wa.me/+5511972553036/?text=";
    String dadosPedido = "--------- NOVO PEDIDO ---------\n";

    pedido!.itens!.forEach((item) {
      Produto produto = item.produto!;
      dadosPedido +=
          " - ${item.quantidade} ${item.produto} (R\$ ${item.total})\n";
    });

    dadosPedido += "\n\nEndereço:\n";
    dadosPedido += "Logradouro: ${pedido!.enderecoLogradouro}\n";
    dadosPedido += "Nº: ${pedido!.enderecoNumero}\n";
    dadosPedido += "Bairroº: ${pedido!.enderecoBairro}\n";
    dadosPedido += "CEP: ${pedido!.enderecoCEP}\n";

    url += dadosPedido;
    await launchUrlString(url);
  }
}
