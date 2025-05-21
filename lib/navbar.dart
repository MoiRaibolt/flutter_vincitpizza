import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 33, 0, 0),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.local_pizza,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Cardápio",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/");
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Sobre a VinciPizza",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/about");
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 33, 0, 0),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                title: const Text(
                  "Sair",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
