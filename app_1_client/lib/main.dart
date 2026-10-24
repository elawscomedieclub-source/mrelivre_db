import 'package:flutter/material.dart';

void main() {
  runApp(const MrEClientApp());
}

class MrEClientApp extends StatelessWidget {
  const MrEClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mr E - Client & Transport',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A)),
        useMaterial3: true,
      ),
      home: const ClientLoginScreen(),
    );
  }
}

class ClientLoginScreen extends StatefulWidget {
  const ClientLoginScreen({Key? key}) : super(key: key);

  @override
  State<ClientLoginScreen> createState() => _ClientLoginScreenState();
}

class _ClientLoginScreenState extends State<ClientLoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _codeSent = false;
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return const ClientHomeScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mr E - Inscription Client', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_pin, size: 80, color: Color(0xFF1E3A8A)),
            const SizedBox(height: 20),
            const Text('Créer un compte Client', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Numéro de téléphone (+228)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 15),
            if (_codeSent) ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Code SMS (Entrez 4821)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_otpController.text == '4821' || _otpController.text.isNotEmpty) {
                    setState(() => _isLoggedIn = true);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size.fromHeight(50)),
                child: const Text('Valider & Entrer', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  if (_phoneController.text.isNotEmpty) {
                    setState(() => _codeSent = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Code SMS envoyé au +228... (Code de test : 4821)')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), minimumSize: const Size.fromHeight(50)),
                child: const Text('Recevoir le Code SMS', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mr E - Carte & Boutiques Lomé', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E3A8A),
        actions: [
          IconButton(
            icon: const Icon(Icons.sos, color: Colors.redAccent, size: 30),
            onPressed: () {
              showDialog(
                context: context,
                builder: (c) => AlertDialog(
                  title: const Text('🚨 URGENCE SOS', style: TextStyle(color: Colors.red)),
                  content: const Text('Alerte et position GPS transmises aux secours et à l\'admin.'),
                  actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('OK'))],
                ),
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.store, color: Color(0xFF1E3A8A), size: 40),
              title: const Text('Boutique Assivito Tech (Lomé)', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Casque Moto (15 000 F), Support Smartphone (5 000 F)'),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Commande envoyée ! Recherche d\'un livreur...')),
                  );
                },
                child: const Text('Commander'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.local_grocery_store, color: Colors.green, size: 40),
              title: const Text('Alimentation Tokoin', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Riz 5kg (4 500 F), Huile 1L (1 200 F)'),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Commande envoyée ! Recherche d\'un livreur...')),
                  );
                },
                child: const Text('Commander'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
