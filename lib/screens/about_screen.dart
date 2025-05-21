import 'package:flutter/material.dart';
import 'package:flutter_vincipizza/navbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "about.facebook",
            onPressed: () async {
              String url = "https://www.facebook.com/faculdade.vincit/";
              await launchUrlString(url);
            },
            backgroundColor: const Color(0xFF1877F2),
            child: const FaIcon(
              FontAwesomeIcons.facebook,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "about.whatsapp",
            onPressed: () async {
              String url = "https://wa.me/+5511972553036/";
              await launchUrlString(url);
            },
            backgroundColor: const Color(0xFF25D366),
            child: const FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(
          child: Text(
            "Sobre a VinciPizza",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: const Navbar(),
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "VinciPizza Pizzaria",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text(
                        "A pizzaria da Faculdade VINCIT",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Endereço: Av. João Paulino Vieira Filho, 870",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "Primeiro andar, Sala 11 a 14 - Centro",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "Maringá - Paraná",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Center(
                        child: Container(
                          width: 350,
                          height: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/maps.png"))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
